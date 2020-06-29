#!/bin/bash
set -e

testAlias+=(
	[btchdd:trusty]='btchdd'
)

imageTests+=(
	[btchdd]='
		rpcpassword
	'
)
