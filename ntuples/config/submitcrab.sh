#voms-proxy-init --voms cms --valid 100:00

# do we submit or just generate submit scripts
dosubmit=true

# start the timer
START=$(date +%s);
printf "Started at ${START}\n\n"

# make the directory where we'll submit from
thesubdir="${subdir}/gitignore/${nversion}"
mkdir -p ${thesubdir} 
printf "Making submit configurations in\n ${thesubdir}\n\n"

# copy necessary files into submit directory
cp "${subdir}/Summer16_23Sep2016BCDV4_DATA_L2Relative_AK8PFchs.txt"   ${thesubdir}
cp "${subdir}/Summer16_23Sep2016BCDV4_DATA_L3Absolute_AK8PFchs.txt"   ${thesubdir} 
cp "${subdir}/Summer16_23Sep2016BCDV4_DATA_L2L3Residual_AK8PFchs.txt" ${thesubdir}  
cp "${subdir}/Summer16_23Sep2016AllV4_DATA.db"                        ${thesubdir}     
cp "${subdir}/Summer16_23Sep2016V4_MC_L2Relative_AK8PFchs.txt"        ${thesubdir}
cp "${subdir}/Summer16_23Sep2016V4_MC_L3Absolute_AK8PFchs.txt"        ${thesubdir}
cp "${subdir}/Summer16_23Sep2016V4_MC.db"                             ${thesubdir}
cp "${subdir}/run_data_80X_Muon.py"   ${thesubdir} 
cp "${subdir}/run_data_80X_Electron.py"  ${thesubdir}
cp "${subdir}/run_mc_80X.py"              ${thesubdir}

printf "process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32(-1) ) \n" >> "${thesubdir}/run_data_80X_Muon.py"  
printf "process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32(-1) ) \n" >> "${thesubdir}/run_data_80X_Electron.py" 
printf "process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32(-1) ) \n" >> "${thesubdir}/run_mc_80X.py"             

printf "process.MessageLogger.cerr.FwkReport.reportEvery = 1000000 \n" >> "${thesubdir}/run_data_80X_Muon.py"   
printf "process.MessageLogger.cerr.FwkReport.reportEvery = 1000000 \n" >> "${thesubdir}/run_data_80X_Electron.py"  
printf "process.MessageLogger.cerr.FwkReport.reportEvery = 1000000 \n" >> "${thesubdir}/run_mc_80X.py"              

# get the DAS name mapping
thedasmap="${listdir}/ntuple/dasmap.list"

# sample names
samples=( \
   "WJets_1"              \
   "WJets_2"              \
)

#  "Data_SingleMu_B_1"    \
#  "Data_SingleEle_B_1"   \
#  "GJets_HT40to100_1"  \

# # double lepton
# "Data_DoubleMu_H_3"    \
# "Data_DoubleMu_H_2"    \
# "Data_DoubleMu_G"      \
# "Data_DoubleMu_F"      \
# "Data_DoubleMu_E"      \
# "Data_DoubleMu_D"      \
# "Data_DoubleMu_C_1"    \
# "Data_DoubleMu_C_2"    \
# "Data_DoubleMu_B_2"    \
# "Data_DoubleMu_B_1"    \
# "Data_DoubleEle_H_3"   \
# "Data_DoubleEle_H_2"   \
# "Data_DoubleEle_G"     \
# "Data_DoubleEle_F"     \
# "Data_DoubleEle_E"     \
# "Data_DoubleEle_D"     \
# "Data_DoubleEle_C"     \
# "Data_DoubleEle_B_2"   \
# "Data_DoubleEle_B_1"   \

# # single lepton
# "Data_SingleMu_H_3"    \
# "Data_SingleMu_H_2"    \
# "Data_SingleMu_G"      \
# "Data_SingleMu_F"      \
# "Data_SingleMu_E"      \
# "Data_SingleMu_D"      \
# "Data_SingleMu_C"      \
# "Data_SingleMu_B_2"    \
# "Data_SingleMu_B_1"    \
# "Data_SingleEle_H_3"   \
# "Data_SingleEle_H_2"   \
# "Data_SingleEle_G"     \
# "Data_SingleEle_F"     \
# "Data_SingleEle_E"     \
# "Data_SingleEle_D"     \
# "Data_SingleEle_C"     \
# "Data_SingleEle_B_2"   \
# "Data_SingleEle_B_1"   \

#  "GJets_HT40to100_1"  \
#  "GJets_HT40to100_2"  \
#  "GJets_HT100to200_1" \
#  "GJets_HT100to200_2" \
#  "GJets_HT200to400_1" \
#  "GJets_HT200to400_2" \
#  "GJets_HT400to600_1" \
#  "GJets_HT400to600_2" \
#  "GJets_HT600toInf_1" \
#  "GJets_HT600toInf_2" \
#  "DY50_1"               \
#  "DY50_2"               \
#  "DY5to50_HT70to100"    \
#  "DY5to50_HT100to200_1" \
#  "DY5to50_HT100to200_2" \
#  "DY5to50_HT200to400_1" \
#  "DY5to50_HT200to400_2" \
#  "DY5to50_HT400to600_1" \
#  "DY5to50_HT400to600_2" \
#  "DY5to50_HT600toInf_1" \
#  "DY5to50_HT600toInf_2" \
#  "TTJets"               \
#  "STs"                  \
#  "STtbar"               \
#  "STt"                  \
#  "STtbarW"              \
#  "STtW"                 \
#  "WJets_1"              \
#  "WJets_2"              \
#  "WW_1"                 \
#  "WW_2"                 \
#  "WZ_1"                 \
#  "WZ_2"                 \
#  "ZZ_1"                 \
#  "ZZ_2"                 \
#  "ZH_Hbb_1"             \
#  "ZH_Hbb_2"             \
#  "ggZH_Hbb_1"           \
#  "ggZH_Hbb_2"           \
#  "ggZH_Hbb_3"           \
#  "ggZH_HSSbbbb_MS_40_ctauS_100"   \
#  "ggZH_HSSdddd_MS_40_ctauS_100"   \

 #  "ggZH_HSSbbbb_MS_15_ctauS_0"     \
 #  "ggZH_HSSbbbb_MS_15_ctauS_0p05"  \
 #  "ggZH_HSSbbbb_MS_15_ctauS_10000" \
 #  "ggZH_HSSbbbb_MS_15_ctauS_1000"  \
 #  "ggZH_HSSbbbb_MS_15_ctauS_100"   \
 #  "ggZH_HSSbbbb_MS_15_ctauS_10"    \
 #  "ggZH_HSSbbbb_MS_15_ctauS_1"     \
 #  "ggZH_HSSbbbb_MS_40_ctauS_0"     \
 #  "ggZH_HSSbbbb_MS_40_ctauS_0p05"  \
 #  "ggZH_HSSbbbb_MS_40_ctauS_10000" \
 #  "ggZH_HSSbbbb_MS_40_ctauS_1000"  \
 #  "ggZH_HSSbbbb_MS_40_ctauS_100"   \
 #  "ggZH_HSSbbbb_MS_40_ctauS_10"    \
 #  "ggZH_HSSbbbb_MS_40_ctauS_1"     \
 #  "ggZH_HSSbbbb_MS_55_ctauS_0"     \
 #  "ggZH_HSSbbbb_MS_55_ctauS_0p05"  \
 #  "ggZH_HSSbbbb_MS_55_ctauS_10000" \
 #  "ggZH_HSSbbbb_MS_55_ctauS_1000"  \
 #  "ggZH_HSSbbbb_MS_55_ctauS_100"   \
 #  "ggZH_HSSbbbb_MS_55_ctauS_10"    \
 #  "ggZH_HSSbbbb_MS_55_ctauS_1"     \
 #  "ggZH_HSSdddd_MS_15_ctauS_0"     \
 #  "ggZH_HSSdddd_MS_15_ctauS_0p05"  \
 #  "ggZH_HSSdddd_MS_15_ctauS_10000" \
 #  "ggZH_HSSdddd_MS_15_ctauS_1000"  \
 #  "ggZH_HSSdddd_MS_15_ctauS_100"   \
 #  "ggZH_HSSdddd_MS_15_ctauS_10"    \
 #  "ggZH_HSSdddd_MS_15_ctauS_1"     \
 #  "ggZH_HSSdddd_MS_40_ctauS_0"     \
 #  "ggZH_HSSdddd_MS_40_ctauS_0p05"  \
 #  "ggZH_HSSdddd_MS_40_ctauS_10000" \
 #  "ggZH_HSSdddd_MS_40_ctauS_1000"  \
 #  "ggZH_HSSdddd_MS_40_ctauS_100"   \
 #  "ggZH_HSSdddd_MS_40_ctauS_10"    \
 #  "ggZH_HSSdddd_MS_40_ctauS_1"     \
 #  "ggZH_HSSdddd_MS_55_ctauS_0"     \
 #  "ggZH_HSSdddd_MS_55_ctauS_0p05"  \
 #  "ggZH_HSSdddd_MS_55_ctauS_10000" \
 #  "ggZH_HSSdddd_MS_55_ctauS_1000"  \
 #  "ggZH_HSSdddd_MS_55_ctauS_100"   \
 #  "ggZH_HSSdddd_MS_55_ctauS_10"    \
 #  "ggZH_HSSdddd_MS_55_ctauS_1"     \
 #  "ggZH_HSSdddd_MS_7_ctauS_0"      \
 #  "ggZH_HSSdddd_MS_7_ctauS_0p05"   \
 #  "ggZH_HSSdddd_MS_7_ctauS_10000"  \
 #  "ggZH_HSSdddd_MS_7_ctauS_1000"   \
 #  "ggZH_HSSdddd_MS_7_ctauS_100"    \
 #  "ggZH_HSSdddd_MS_7_ctauS_10"     \
 #  "ggZH_HSSdddd_MS_7_ctauS_1"      \
 # )
                                                           
# print which samples we're running over
printf "For:\n"
for samplename in ${samples[@]} 
do
 printf " ${samplename}\n"
done

# loop over mc samples
for samplename in ${samples[@]}
do
 printf "\n******************************************************\n"
 if [ ${dosubmit} = true ]
 then
  printf "** \n"
  printf "** --- SUBMITTING --- \n"
  printf "** \n"
 fi
 printf "** Sample: ${samplename} \n"
 printf "******************************************************\n"
 printf "******************************************************\n\n"

 datasetname="$(grep -P ${samplename} ${thedasmap} | sed -n -e "s@ ${samplename}    @@p")"

 submitname="submit_${samplename}"
 submitfile="${thesubdir}/${submitname}.py"

 # set veriables for submitting this specific sample
 WORKAREA="'crabsubmits_${nversion}'"

 CMSRUNCONFIG="'run_mc_80X.py'" 
 INPUTFILES="'Summer16_23Sep2016V4_MC_L2Relative_AK8PFchs.txt', 'Summer16_23Sep2016V4_MC_L3Absolute_AK8PFchs.txt', 'Summer16_23Sep2016V4_MC.db'"
 if [[ "${samplename:0:13}" == "Data_SingleMu" ]]
 then
  CMSRUNCONFIG="'run_data_80X_Muon.py'" 
  INPUTFILES="'Summer16_23Sep2016BCDV4_DATA_L2Relative_AK8PFchs.txt', 'Summer16_23Sep2016BCDV4_DATA_L3Absolute_AK8PFchs.txt', 'Summer16_23Sep2016BCDV4_DATA_L2L3Residual_AK8PFchs.txt', 'Summer16_23Sep2016AllV4_DATA.db' "
 elif [[ "${samplename:0:14}" == "Data_SingleEle" ]]
 then
  CMSRUNCONFIG="'run_data_80X_Electron.py'" 
  INPUTFILES="'Summer16_23Sep2016BCDV4_DATA_L2Relative_AK8PFchs.txt', 'Summer16_23Sep2016BCDV4_DATA_L3Absolute_AK8PFchs.txt', 'Summer16_23Sep2016BCDV4_DATA_L2L3Residual_AK8PFchs.txt', 'Summer16_23Sep2016AllV4_DATA.db' "
 fi

 NUNITS="-1"
 UPERJOB="1"
 SPLITTING="'FileBased'"
 REQUESTNAME="'${samplename}'"
 DATASET="'${datasetname}'"
 STORESITE="'T2_US_Wisconsin'"
 OUTLFNBASE="'/store/user/tmperry/${nversion}'"
 MAXMEM="4000"

 #STORESITE="'T2_US_FNAL'"
 #OUTLFNBASE="'/eos/store/tmperry/${nversion}'"

 printf "WORKAREA      ${WORKAREA}     \n" 
 printf "CMSRUNCONFIG  ${CMSRUNCONFIG} \n" 
 printf "INPUTFILES    ${INPUTFILES}   \n" 
 printf "NUNITS        ${NUNITS}       \n" 
 printf "UPERJOB       ${UPERJOB}      \n" 
 printf "SPLITTING     ${SPLITTING}    \n" 
 printf "REQUESTNAME   ${REQUESTNAME}  \n" 
 printf "DATASET       ${DATASET}      \n" 
 printf "STORESITE     ${STORESITE}    \n" 
 printf "OUTLFNBASE    ${OUTLFNBASE}   \n" 
 printf "MAXMEM        ${MAXMEM}       \n" 

 # copy and then fill template for crab submits
 cp ${subdir}/crab_template.py             "${submitfile}"
 sed -i "s@WORKAREA@${WORKAREA}@g"         "${submitfile}"
 sed -i "s@CMSRUNCONFIG@${CMSRUNCONFIG}@g" "${submitfile}" 
 sed -i "s@INPUTFILES@${INPUTFILES}@g"     "${submitfile}" 
 sed -i "s@NUNITS@${NUNITS}@g"             "${submitfile}" 
 sed -i "s@UPERJOB@${UPERJOB}@g"           "${submitfile}" 
 sed -i "s@SPLITTING@${SPLITTING}@g"       "${submitfile}" 
 sed -i "s@REQUESTNAME@${REQUESTNAME}@g"   "${submitfile}" 
 sed -i "s@DATASET@${DATASET}@g"           "${submitfile}" 
 sed -i "s@STORESITE@${STORESITE}@g"       "${submitfile}" 
 sed -i "s@OUTLFNBASE@${OUTLFNBASE}@g"     "${submitfile}" 
 sed -i "s@MAXMEM@${MAXMEM}@g"             "${submitfile}" 

 # submit the jobs
 if [ ${dosubmit} = true ]
 then
  pushd ${thesubdir} > /dev/null
  python ${submitfile}
  popd > /dev/null
 fi

done

# end the timer
END=$(date +%s);
printf "\nStarted at ${START}\n"
printf "Ended at   ${END}\n\n"
