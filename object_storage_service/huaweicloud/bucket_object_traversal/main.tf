provider "huaweicloud" {
  region     = "cn-north-1"
  access_key = var.huaweicloud_access_key
  secret_key = var.huaweicloud_secret_key
}

resource "huaweicloud_obs_bucket" "create_bucket" {
  bucket        = "hx-cloud-security-${random_string.random_suffix.result}"
  force_destroy = true
  acl           = "public-read"
}

resource "huaweicloud_obs_bucket_object" "object" {
  bucket = huaweicloud_obs_bucket.create_bucket.id
  key    = "flag1650859"
  source = "flag1650859"
  depends_on = [
    huaweicloud_obs_bucket.create_bucket
  ]
}

resource "huaweicloud_obs_bucket_policy" "policy" {
  bucket = huaweicloud_obs_bucket.create_bucket.id
  policy = <<POLICY
{
  "Statement": [
    {
      "Sid": "HuoXianPolicy",
      "Effect": "Allow",
      "Principal": {"ID": "*"},
      "Action": ["GetObject"],
      "Resource": "${huaweicloud_obs_bucket.create_bucket.id}/*"
    }
  ]
}
POLICY
  depends_on = [
    huaweicloud_obs_bucket.create_bucket
  ]
}

resource "random_string" "random_suffix" {
  length  = 5
  special = false
  upper   = false
}

