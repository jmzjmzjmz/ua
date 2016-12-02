crontab -r;
echo password | sudo -S crontab -r;

# (crontab -l 2>/dev/null; echo "* * * * * ~/m-mart/scripts/checkResetCron.sh")| crontab -

( echo password | sudo -S crontab -l 2>/dev/null; echo "0 6 * * * /sbin/shutdown -r now") | sudo crontab -


# echo password | sudo -S /sbin/shutdown -r now
