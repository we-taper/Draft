echo off
git status
echo "Continue to git add & commit?"
pause
git add --all
git commit -a
echo "Continue to push?"
pause
git push origin master
echo "Press any key to exit"
pause
exit