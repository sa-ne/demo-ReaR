#!/bin/bash

TextReset='\033[0m'
TextGreen='\033[32m'
TextBlue='\033[34m'
TextLightGrey='\033[37m'
TextBold='\033[1m'

FormatTextPause="$TextReset $TextLightGrey"  # Pause & continue
FormatTextCommands="$TextReset $TextGreen" # Commands to execute
FormatTextSyntax="$TextReset $TextBlue $TextBold" # Command Syntax & other text

# Place before command line to reset text format
FormatRunCommand="echo -e $TextReset"

# Reset text if script exits abnormally
trap 'echo -e $TextReset;exit' 1 2 3 15

clear
echo -e $FormatTextSyntax "

   Install the rear package and its dependencies by running the following command as root:

"
echo -e $FormatTextCommands "
	# yum install rear genisoimage syslinux

"
$FormatRunCommand
yum install -y rear genisoimage syslinux

echo -e $FormatTextPause && read -p "<-- Press any key to continue -->" NULL
$FormatRunCommand
