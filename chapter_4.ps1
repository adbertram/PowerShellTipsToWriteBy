#region Write Comments Before Coding

## Find the file here
## Set the file's ACL to read/write for all users
## Read the file and parse the computer name from it
## Attempt to connect to the computer and if successful, find the service

#region Find the file here
#endregion
#region Set the file's ACL to read/write for all users
#endregion
#region Read the file and parse the computer name from it
#endregion
#region Attempt to connect to the computer and if successful, find the service
#endregion

#endregion

#region Use Your Code As a Todo List
## Run some program
& C:\Program.exe
## Find the log file it generates and send it back to me
Get-ChildItem -Path 'C:\Program Files\Program\Logs' -Filter '*.log' | Get-Content

## TODO: This needs to run with Start-Process. More control that way
## Run some program
& C:\Program.exe
## TODO: Sometimes this program creates a .txt file as the log. Need to account for this edge case.
## Find the log file it generates and send it back to me
Get-ChildItem -Path 'C:\Program Files\Program\Logs' -Filter '*.log' | Get-Content
#endregion