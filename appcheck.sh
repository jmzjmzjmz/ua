#!/bin/sh
if ps -ef | grep -v grep | grep UASerialTest2.app ; then
        echo "UALED already running"
	ps -ef | grep "UASerialTest2.app" | awk '{print $2}' | xargs kill
        exit 0
else
        open /LED\ Projects/UnderArmourSidewalk/Processing/UASerialTest2/application.macosx/UASerialTest2.app
        echo "UALED not running. Launching..."
        exit 0
fi

