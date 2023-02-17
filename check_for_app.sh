#!/bin/bash

application_name="//Applications/{Application title here}"

if [ -d "${application_name}" ]
then
    echo "Has application installed."     
else
	echo "Does not have application installed."
fi
