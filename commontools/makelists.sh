#!/bin/bash

# Makes a list of files in eos
# then greps through to separate into samples
# 
# output files are xxx/lists/<sample>.list
# formatted as one file per line: /store/group/xxx.root

# don't forget to source setup.sh (from xxx/LLDJstandalones)
mkdir -p "${listdir}"

#depricated?
#filetype="AOD" # miniAOD=""
filetype="" # miniAOD=""

makealist () {
 printf "Making %s\n" $1
 fullsamplename=$(grep -i "$2" ${listdir}/allfiles${filetype}.masterlist)
 printf "%s\n"  ${fullsamplename} > ${listdir}/$1${filetype}.list
 sed -i -e "s@/eos/uscms@@" ${listdir}/$1${filetype}.list
}

makealist "DY10to50"                            "/DYJetsToLL_M-10to50_"
makealist "DY5to50_HT70To100"                   "/DYJetsToLL_M-5to50_HT-70to100_"
makealist "DY5to50_HT100To200"                  "/DYJetsToLL_M-5to50_HT-100to200_"
makealist "DY5to50_HT200To400"                  "/DYJetsToLL_M-5to50_HT-200to400_"
makealist "DY5to50_HT400To600"                  "/DYJetsToLL_M-5to50_HT-400to600_"
makealist "DY5to50_HT600ToInf"                  "/DYJetsToLL_M-5to50_HT-600toInf_"
makealist "DY50"                                "/DYJetsToLL_M-50_"
makealist "ggZH_HToBB_ZToLL"                    "/ggZH_HToBB_ZToLL_"
makealist "ggZH_HToSSTobbbb_MS15_ctauS0"        "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-0_"
makealist "ggZH_HToSSTobbbb_MS15_ctauS0p05"     "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-0p05_"
makealist "ggZH_HToSSTobbbb_MS15_ctauS1"        "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-1_"
makealist "ggZH_HToSSTobbbb_MS15_ctauS10"       "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-10_"
makealist "ggZH_HToSSTobbbb_MS15_ctauS100"      "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-100_"
makealist "ggZH_HToSSTobbbb_MS15_ctauS1000"     "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-1000_"
makealist "ggZH_HToSSTobbbb_MS15_ctauS10000"    "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-10000_"
makealist "ZH_HToSSTobbbb_MS15_ctauS0"          "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-0_"
makealist "ZH_HToSSTobbbb_MS15_ctauS0p05"       "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-0p05_"
makealist "ZH_HToSSTobbbb_MS15_ctauS1"          "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-1_"
makealist "ZH_HToSSTobbbb_MS15_ctauS10"         "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-10_"
makealist "ZH_HToSSTobbbb_MS15_ctauS100"        "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-100_"
makealist "ZH_HToSSTobbbb_MS15_ctauS1000"       "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-1000_"
makealist "ZH_HToSSTobbbb_MS15_ctauS10000"      "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-15_ctauS-10000_"
makealist "ggZH_HToSSTobbbb_MS40_ctauS0"        "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-0_"
makealist "ggZH_HToSSTobbbb_MS40_ctauS0p05"     "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-0p05_"
makealist "ggZH_HToSSTobbbb_MS40_ctauS1"        "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-1_"
makealist "ggZH_HToSSTobbbb_MS40_ctauS10"       "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-10_"
makealist "ggZH_HToSSTobbbb_MS40_ctauS100"      "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-100_"
makealist "ggZH_HToSSTobbbb_MS40_ctauS1000"     "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-1000_"
makealist "ggZH_HToSSTobbbb_MS40_ctauS10000"    "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-10000_"
makealist "ZH_HToSSTobbbb_MS40_ctauS0"          "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-0_"
makealist "ZH_HToSSTobbbb_MS40_ctauS0p05"       "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-0p05_"
makealist "ZH_HToSSTobbbb_MS40_ctauS1"          "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-1_"
makealist "ZH_HToSSTobbbb_MS40_ctauS10"         "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-10_"
makealist "ZH_HToSSTobbbb_MS40_ctauS100"        "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-100_"
makealist "ZH_HToSSTobbbb_MS40_ctauS1000"       "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-1000_"
makealist "ZH_HToSSTobbbb_MS40_ctauS10000"      "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-10000_"
makealist "ggZH_HToSSTobbbb_MS55_ctauS0"        "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-0_"
makealist "ggZH_HToSSTobbbb_MS55_ctauS0p05"     "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-0p05_"
makealist "ggZH_HToSSTobbbb_MS55_ctauS1"        "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-1_"
makealist "ggZH_HToSSTobbbb_MS55_ctauS10"       "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-10_"
makealist "ggZH_HToSSTobbbb_MS55_ctauS100"      "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-100_"
makealist "ggZH_HToSSTobbbb_MS55_ctauS1000"     "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-1000_"
makealist "ggZH_HToSSTobbbb_MS55_ctauS10000"    "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-10000_"
makealist "ZH_HToSSTobbbb_MS55_ctauS0"          "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-0_"
makealist "ZH_HToSSTobbbb_MS55_ctauS0p05"       "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-0p05_"
makealist "ZH_HToSSTobbbb_MS55_ctauS1"          "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-1_"
makealist "ZH_HToSSTobbbb_MS55_ctauS10"         "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-10_"
makealist "ZH_HToSSTobbbb_MS55_ctauS100"        "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-100_"
makealist "ZH_HToSSTobbbb_MS55_ctauS1000"       "/ZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-1000_"
makealist "ZH_HToSSTobbbb_MS55_ctauS10000"      "/ggZH_HToSSTobbbb_ZToLL_MH-125_MS-55_ctauS-10000_"
makealist "GJets_HT40To100"                     "/GJets_HT-40To100_"
makealist "GJets_HT100To200"                    "/GJets_HT-100To200_"
makealist "GJets_HT200To400"                    "/GJets_HT-200To400_"
makealist "GJets_HT400To600"                    "/GJets_HT-400To600_"
makealist "GJets_HT600ToInf"                    "/GJets_HT-600ToInf_"
makealist "ST_s"                                "/ST_s-channel_4f_leptonDecays_"
makealist "STbar_t"                             "/ST_t-channel_antitop_4f_inclusiveDecays_"
makealist "ST_t"                                "/ST_t-channel_top_4f_inclusiveDecays_"
makealist "STbar_tW"                            "/ST_tW_antitop_5f_NoFullyHadronicDecays_"
makealist "ST_tW"                               "/ST_tW_top_5f_NoFullyHadronicDecays_"
makealist "TTtoLL"                              "/TTJets_DiLept_"
makealist "TTtoLfromTbar"                       "/TTJets_SingleLeptFromTbar_"
makealist "TTtoLfromT"                          "/TTJets_SingleLeptFromT_"
makealist "WG"                                  "/WGToLNuG_"
makealist "WJetsToLNu"                          "/WJetsToLNu_"
makealist "WWToLNuLNu"                          "/WWTo2L2Nu_"
makealist "WWToLNuQQ"                           "/WWToLNuQQ_"
makealist "WZToL3Nu"                            "/WZTo1L3Nu_"
makealist "WZTo3LNu"                            "/WZTo3LNu_"
makealist "WZToLNu2QorQQ2L"                     "/WZToLNu2QorQQ2L_"
makealist "ZG"                                  "/ZGTo2LG_"
makealist "ZH_HToBB_ZToLL"                      "/ZH_HToBB_ZToLL_M125_"
makealist "ZZToLLNuNu"                          "/ZZTo2L2Nu_"
makealist "ZZToLLQQ"                            "/ZZTo2L2Q_"
makealist "ZZToNuNuQQ"                          "/ZZTo2Q2Nu_"
makealist "ZZToLLLL"                            "/ZZTo4L_"
makealist "SingleElectron"                      "/SingleElectron"
makealist "SingleMuon"                          "/SingleMuon"
makealist "DoubleEG"                            "/DoubleEG"
makealist "DoubleMuon"                          "/DoubleMuon"
makealist "MuonEG"                              "/MuonEG"

