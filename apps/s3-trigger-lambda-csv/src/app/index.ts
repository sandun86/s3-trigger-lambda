import config from './config';
import { S3Event } from 'aws-lambda';

export const handler = async (event: S3Event): Promise<string | undefined> => {
  console.log('Starting to save thecsv data subroutine');
  console.log(event);
  try {
    const s3RecordingPath = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, ' '));
    // Add what your logic here
    // Example: save the data into DB or trigger a email
    return s3RecordingPath; //s3-trigger-csv/sample.csv
  } catch (error) {
    console.log(error);
    return;
  }
}
