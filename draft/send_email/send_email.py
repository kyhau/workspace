import boto3

email_from = "noreply@example.com"
email_to = "dummy@example.com"
email_subject = "Subject"
email_body = "Body"


def lambda_handler(event, context):
    """
    Simple Lambda function to send an email through Amazon SES.
    """
    ses_client = boto3.client("ses", region_name="us-west-2")
    response = ses_client.send_email(
        Source = email_from,
        Destination={
            "ToAddresses": [email_to]
        },
        Message={
            "Subject": {
                "Data": email_subject
            },
            "Body": {
                "Text": {
                    "Data": email_body
                }
            }
        }
    )