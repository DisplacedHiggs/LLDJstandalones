#!/bin/bash

export depot="/eos/uscms/store/group/lpchbb/LLDJntuples"
export nversion="ttAOD"
export aversion="Daniel_testZH"

pushd `dirname ${BASH_SOURCE[0]}` > /dev/null
export basedir=`pwd`
popd > /dev/null

export listdir="${basedir}/lists"
export rootdir="${basedir}/roots"
export plotdir="${basedir}/plots"
export andir="${basedir}/analysis"

export subdir="${basedir}/ntuples/config"
export asubdir="${basedir}/submitters"
