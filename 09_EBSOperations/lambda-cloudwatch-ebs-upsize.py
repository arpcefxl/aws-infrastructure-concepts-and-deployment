import boto3
import json
import logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    #logger.debug(event)
    
    #fun translation of alarm event into something Python can use
    alarm_dict=json.dumps(event)
    alarm=json.loads(alarm_dict)
    message=json.loads(alarm['Records'][0]['Sns']['Message'])
    
    #extract Instance ID and EBS Device from the alarm
    instanceid=message['Trigger']['Dimensions'][1]['value']
    device=message['Trigger']['Dimensions'][4]['value']
    
    #extract the last letter of the device to translate from xvd to sd
    ebsdev=device[-1:]

    #Print some information
    logger.info("Instance ID =%s", instanceid)
    logger.info("Device =%s", device)
    
    #get the volume object
    client = boto3.client('ec2')
    volumeraw = client.describe_volumes(
        Filters=[
            {
                'Name': 'attachment.instance-id', 'Values': [instanceid],
                'Name': 'attachment.device', 'Values': ['/dev/sd' + ebsdev]
                    }
                ]
        )
        
    #fun translation of volume object data into something Python can use
    volumedict = json.dumps(volumeraw, default=str)
    volume = json.loads(volumedict)
    
    #extract volume ID
    volumeid = volume['Volumes'][0]['VolumeId']
    
    #print some information
    logger.info("Volume Size=%s", volume['Volumes'][0]['Size'])
    logger.info("Volume Device=%s", volume['Volumes'][0]['Attachments'][0]['Device'])
    logger.info("Volume ID=%s", volumeid)
    
    #calculate the new volume size
    newsize = volume['Volumes'][0]['Size'] + 10
    
    #print some information
    logger.info("New volume size =%s",newsize)
    
    #modify the volume with the increased size
    client.modify_volume(
        VolumeId=volumeid,
        Size=newsize
        )

    #Issue SSM Run Command to log into the instance, wait for a few seconds, then upsize the filesystem
    client = boto3.client('ssm')
    response = client.send_command(
    Targets=[
        {   
            'Key': 'InstanceIds',
            'Values': [
                instanceid,
            ]
        },
    ],
    DocumentName='AWS-RunShellScript',
    DocumentVersion='1',
    TimeoutSeconds=123,
    Parameters={
        'workingDirectory': [
            '',
        ],
        'executionTimeout': [
            '360',
        ],
        'commands': [
            'sleep 15',
            'sudo xfs_growfs /dev/' + device
        ],
        
    },
    MaxConcurrency='1',
    MaxErrors='0'
)   

