
#ifndef analyzer_scalefactors_h
#define analyzer_scalefactors_h

#include "analyzer_selections.h"

class analyzer_scalefactors : public analyzer_selections {


public :

                  analyzer_scalefactors();
   virtual        ~analyzer_scalefactors(); 

 // event based weights
 Double_t         makeEventWeight(Double_t crossSec, Double_t lumi,
                                  Double_t nrEvents);
 void             loadPUWeight();
 Double_t         makePUWeight();
 TH1F*            PUWeights;
 void             loadElectronWeight( TString eleid );
 Double_t         makeElectronWeight( std::vector<int> &electron_list );
 TH2F*            EleWeights;

 void             loadEff();
 TH1F*            h_eff;

};

#endif
