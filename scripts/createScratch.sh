#!/bin/sh

sfdx force:org:create -f config\project-scratch-def.json -a FM_SCRATCH
sfdx force:source:push -u FM_SCRATCH
sfdx force:apex:execute -u FM_SCRATCH -f scripts\generateSampleObjects.apex
sfdx force:org:open -u FM_SCRATCH
sfdx force:org:open -u FM_SCRATCH