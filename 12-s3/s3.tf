resource "aws_s3_bucket" "mybucket" {
    count = length(var.bucket_name)
    bucket = var.bucket_name[count.index]
}

resource "aws_s3_bucket_versioning" "bucketversioning" {
    count = length(var.bucket_name)
    bucket = aws_s3_bucket.mybucket[count.index].id
    versioning_configuration {
      status = "Enabled"
    }
}


# or


resource "aws_s3_bucket" "foreach_bucket" {
  for_each = toset(var.bucket_name)
  bucket = each.value
}

resource "aws_s3_bucket_versioning" "for_each_versioning" {
   for_each = aws_s3_bucket.foreach_bucket
   bucket = each.value.id
   versioning_configuration {
     status = "Enabled"
   }
}