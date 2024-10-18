
resource "aws_acm_certificate" "jenkins_acm_certificate" {
domain_name = var.domain_name
validation_method = "DNS"

tags = {
  Environment = "dev"
}
lifecycle {
  create_before_destroy = true
}

}




resource "aws_route53_record" "jenkins_route53_CName_record" {
  for_each = {
    for dvo in aws_acm_certificate.jenkins_acm_certificate.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = "Z0671589BT7MHBSY40SQ"
    
    }
  }
  allow_overwrite = true 
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id = each.value.zone_id
  
}


resource "aws_acm_certificate_validation" "jenkins_acm_certificate_validation"  {
  certificate_arn         = aws_acm_certificate.jenkins_acm_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.jenkins_route53_CName_record : record.fqdn]
}
