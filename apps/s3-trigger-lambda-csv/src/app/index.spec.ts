import { handler } from './index';
import { S3Event, Context } from 'aws-lambda';
import { MockProxy, mock } from 'jest-mock-extended';

const s3EventParams = {
    "Records": [
        {
            "eventVersion": "2.1",
            "eventSource": "aws:s3",
            "awsRegion": "ap-northeast-1",
            "eventTime": "2024-01-24T06:28:05.323Z",
            "eventName": "ObjectCreated:Put",
            "userIdentity": {
                "principalId": "AWS:AIDAX4NZUZB6A7VTQEN6N"
            },
            "requestParameters": {
                "sourceIPAddress": ""
            },
            "responseElements": {
                "x-amz-id-2": "",
                "x-amz-request-id": "EXAMPLE1234567890ABCDEF1234567890ABCDEF"
            },
            "s3": {
                "s3SchemaVersion": "1.0",
                "configurationId": "tf-s3-lambda-20240124061126190700000001",
                "bucket": {
                    "name": "",
                    "ownerIdentity": {
                        "principalId": ""
                    },
                    "arn": "arn:aws:s3:::"
                },
                "object": {
                    "key": "s3-trigger-csv/sample.csv",
                    "size": 456,
                    "eTag": "",
                    "versionId": "",
                    "sequencer": "0065B0ADF3E37A9F48"
                }
            }
        }
    ]
}

describe('S3 Trigger', () => {
    let context: MockProxy<Context>;

    afterAll(() => {
        console.log('After all');
    });

    beforeAll(() => {
        context = mock<Context>();
    });

    it('should be return success response', async () => {
        const event: S3Event = s3EventParams;

        const result = await handler(event);

        expect(result).toEqual(s3EventParams.Records[0].s3.object.key);
    });

    it('should be return error response', async () => {
        //TODO: mock what ever your logics and return a exception
        const event: S3Event = s3EventParams;

        const result = await handler(event);

        expect(result).toEqual(undefined);
    });
});