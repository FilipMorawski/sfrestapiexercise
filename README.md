# Rest API resfresh sf App

This app handles change in database and refresh front-end components in real time.

##Choosing a solution method

For a task, i created 3 solution methods
1. Standard Sf front-end and no APEX <br/>
This solution is a some type of hack. It uses a wired built-in adapter getRecord(recordId, fields : [fieldnames]) </br>
By placing empty LWC component in Object Record Page and standard Record details, calling method refreshApes(wired objects) refreshes standard sf components with new values.</br>
Because it consumes Change Data Capture Events it works with every objects changes - REST Api changes, Anonymous Apex Changes etc.

2. Custom LWC front-end and no APEX <br/>
This solution is similar to 1-st solution but it uses real-lwc component to obtain record data. Compares to the first one developer needs to declare all fields of object manually in javasript controller, but it is possible to create own independent view. </br>

3. Custom LWC front-end and Apex back-end <br/>
This solution is the most flexible one - but also the heaviest one -  it uses custom apex back-end to get records and custom-lwc-view to display records

All solutions subscribes the Change Data Captuere events, so we can use it with sf standard endpoints, custom endpoints or in any action witch execute dml in database.
In this task it was mention to use standard REST API - that's why i haven't built my own rest api endpoints, but it should work with custom endpoints anyway. 

### Deploy method

Clone the repository https://github.com/FilipMorawski/sfrestapiexercise.git </br>

Next you should create scratch org and deploy code into it by paste 

sfdx force:org:create -f config\project-scratch-def.json -a FM_SCRATCH
sfdx force:source:push -u FM_SCRATCH
sfdx force:apex:execute -u FM_SCRATCH -f scripts\generateSampleObjects.apex
sfdx force:org:open -u FM_SCRATCH
sfdx force:org:open -u FM_SCRATCH

to the terminal. Those actions should create sfdx scratch org, deploy code to it and create test objects.

Before that you should checkout from branch with solution that you chose.

1. noFrontAndBackSolution
2. lwcNoApexSolution
3. lwcApexSolution

and then execute scripts mentioned before.

