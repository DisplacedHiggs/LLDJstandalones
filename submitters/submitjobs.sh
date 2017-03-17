#!/bin/bash

# script to generate submit files
# and optionally to submit to condor (@FNAL)

# source xx/LLDJ/setup.sh for ${version}

doSubmit=false
lumi=20000
nevents=100000

printf "Version: ${version}\n"

# tar up your present CMSSW area
if [ ! -a ${CMSSW_VERSION}.tar.gz ] 
then 
 tar --exclude-caches-all --exclude-vcs -zcf ${CMSSW_VERSION}.tar.gz -C ${CMSSW_BASE}/.. ${CMSSW_BASE} --exclude=src --exclude=tmp
fi

makeasubmitdir () {
 printf "Making submits for $1\n"
 
 # go to the directory
 mkdir -p gitignore/${version}/$1
 pushd    gitignore/${version}/$1
 #printf " The directory is %s\n" $(pwd)
 
 mkdir -p logs
 
 # write base for submit file
 printf "universe = vanilla\n" > submitfile
 printf "Executable = \$ENV(CMSSW_BASE)/src/LLDJstandalones/submitters/runjob.sh\n" >> submitfile
 printf "Should_Transfer_Files = YES \n" >> submitfile
 printf "WhenToTransferOutput = ON_EXIT\n" >> submitfile
 printf "Transfer_Input_Files = \$ENV(CMSSW_BASE)/src/LLDJstandalones/submitters/CMSSW_8_0_18_patch1.tar.gz,\$ENV(CMSSW_BASE)/src/LLDJstandalones/analyzers/runanalyzer.exe,\$ENV(CMSSW_BASE)/src/LLDJstandalones/lists/$1.list,\$ENV(CMSSW_BASE)/src/LLDJstandalones/lists/$1.info\n" >> submitfile
 printf "notify_user = $(whoami)@cern.ch\n" >> submitfile
 printf "x509userproxy = \$ENV(X509_USER_PROXY)\n" >> submitfile
 printf "\n" >> submitfile
 printf "Output = logs/runanalyzer_\$(Cluster)_\$(Process).stdout\n" >> submitfile
 printf "Error  = logs/runanalyzer_\$(Cluster)_\$(Process).stderr\n" >> submitfile
 printf "Log    = logs/runanalyzer_\$(Cluster)_\$(Process).log\n" >> submitfile
 printf "\n" >> submitfile
 
 # choose your favorite jets
 for jettype in \
  "ALLCALOJETS"                      \
  "ALLCALOJETSMATCHED"               \
  "BASICCALOJETS"                    \
  "BASICCALOJETS1"                   \
  "BASICCALOJETS1MATCHED"            \
  "BASICCALOJETS1PT20"               \
  "BASICCALOJETS1PT20MATCHED"        \
  "BASICCALOJETSMATCHED"             \
  "INCLUSIVETAGGEDCALOJETS"          \
  "INCLUSIVETAGGEDCALOJETS20"        \
  "INCLUSIVETAGGEDCALOJETS20MATCHED" \
  "INCLUSIVETAGGEDCALOJETS60"        \
  "INCLUSIVETAGGEDCALOJETS60MATCHED" \
  "INCLUSIVETAGGEDCALOJETSA"         \
  "INCLUSIVETAGGEDCALOJETSAMATCHED"  \
  "INCLUSIVETAGGEDCALOJETSB"         \
  "INCLUSIVETAGGEDCALOJETSBMATCHED"  \
  "INCLUSIVETAGGEDCALOJETSC"         \
  "INCLUSIVETAGGEDCALOJETSCMATCHED"  \
  "INCLUSIVETAGGEDCALOJETSD"         \
  "INCLUSIVETAGGEDCALOJETSDMATCHED"  \
  "INCLUSIVETAGGEDCALOJETSE"         \
  "INCLUSIVETAGGEDCALOJETSEMATCHED"  \
  "INCLUSIVETAGGEDCALOJETSF"         \
  "INCLUSIVETAGGEDCALOJETSFMATCHED"  \
  "INCLUSIVETAGGEDCALOJETSMATCHED" 
 
 do
  printf "Arguments = \$ENV(CMSSW_VERSION) $1 ${lumi} ${nevents} ${jettype}\n" >> submitfile
  printf "Queue\n" >> submitfile
  printf "\n" >> submitfile
 done

 if [ ${doSubmit} = true ]
 then
  condor_submit submitfile
 fi
 
 popd
}

for sample in \
 "DY50"    \
 "DY5to50" \
 "TTbar"   \
 "STs"     \
 "STtbar"  \
 "STt"     \
 "STtbarW" \
 "STtW"    \
 "WJets"   \
 "WW"      \
 "ZZ"      \
 "WZ"      
do
 makeasubmitdir ${sample}
done

#makemanylists ${doZHtoLLbb} "ZHtoLLbb" "ZH_HToBB_ZToLL" 
#makemanylists ${doSignal}   "Signal"   "HToSSTobbbb" 

