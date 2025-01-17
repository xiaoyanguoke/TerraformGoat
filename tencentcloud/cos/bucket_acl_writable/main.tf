provider "tencentcloud" {
  secret_id  = var.tencentcloud_secret_id
  secret_key = var.tencentcloud_secret_key
  region     = "ap-beijing"
}

resource "tencentcloud_cos_bucket" "huoxian_cos_bucket" {
  bucket   = "houxian${random_string.random_suffix.result}-${var.tencentcloud_app_id}"
  acl_body = <<EOF
<AccessControlPolicy>
    <Owner>
        <ID>qcs::cam::uin/${var.tencentcloud_account_id}:uin/${var.tencentcloud_account_id}</ID>
    </Owner>
    <AccessControlList>
        <Grant>
            <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
                <URI>http://cam.qcloud.com/groups/global/AllUsers</URI>
            </Grantee>
            <Permission>READ_ACP</Permission>
        </Grant>
        <Grant>
            <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
                <URI>http://cam.qcloud.com/groups/global/AllUsers</URI>
            </Grantee>
            <Permission>WRITE_ACP</Permission>
        </Grant>
        <Grant>
            <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CanonicalUser">
                <ID>qcs::cam::uin/${var.tencentcloud_account_id}:uin/${var.tencentcloud_account_id}</ID>
                <DisplayName>qcs::cam::uin/${var.tencentcloud_account_id}:uin/${var.tencentcloud_account_id}</DisplayName>
            </Grantee>
            <Permission>FULL_CONTROL</Permission>
        </Grant>
    </AccessControlList>
</AccessControlPolicy>
EOF
}

resource "tencentcloud_cos_bucket_object" "huoxian_cos_object" {
  bucket     = tencentcloud_cos_bucket.huoxian_cos_bucket.bucket
  key        = "flag_is_{Congratulations on getting flag}"
  source     = "./flag_is_{Congratulations on getting flag}"
  depends_on = [tencentcloud_cos_bucket.huoxian_cos_bucket]
}

resource "random_string" "random_suffix" {
  length  = 5
  special = false
  upper   = false
}