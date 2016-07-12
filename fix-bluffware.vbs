
	' Thanks to Ansgar Wiechers for permission elevation script
	' From : http://stackoverflow.com/questions/17466681/how-to-run-vbs-as-administrator-from-vbs
	If Not WScript.Arguments.Named.Exists("elevate") Then
		CreateObject("Shell.Application").ShellExecute WScript.FullName, WScript.ScriptFullName & " /elevate", "", "runas", 1
		WScript.Quit
	End If


	' Copyright 18/03/16 Jake Nicholson

	Dim gFolderCount : gFolderCount = 0
	Dim gFileCount : gFileCount = 0
	Dim gInfectedFileCount : gInfectedFileCount = 0
	Dim oFS
	
	Set oFS = CreateObject("Scripting.FileSystemObject")

	Function ListFolders(oParent)
	
		Dim oFolders, oFolder, sOut
		
		sOut = ""
	
		Set oFolders = oParent.SubFolders

		On Error Resume Next' Ignore "Access Denied" errors. (If we can't get to it with elevated permissions, it's a fair assumption that the malware hasn't reached it)
		
		For Each oFolder In oFolders
		
			gFolderCount = gFolderCount + 1
			
			Call ListFolders(oFolder)
		
		Next
		
		Dim oFile, oFiles, sFullPath
		
		Set oFiles = oParent.Files
		
		For Each oFile In oFiles
		
			gFileCount = gFileCount + 1
			
			If Right(oFile.Name, Len(".crypted")) = ".crypted" Then
			
				gInfectedFileCount = gInfectedFileCount + 1
				
				sFullPath = Left(oFile.Path, Len(oFile.Path) - Len(".crypted"))
			
				oFile.Move sFullPath
			
			End If
		
		Next
		
		Set oFolders = Nothing
	
	End Function

	Dim oRoot, sOutput

	Set oRoot = oFS.GetFolder("C:\")
	
	sOutput = ListFolders(oRoot)
	
	WScript.Echo "Scan complete. Found " & gInfectedFileCount & " infected files and " & (gFileCount - gInfectedFileCount) & " clean files in " & gFolderCount & " folders."
	
	Set oRoot = Nothing
	
	Set oFS = Nothing