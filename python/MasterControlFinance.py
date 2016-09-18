'''
    MasterControlFinance
'''

import sys, os
from MasterControl import MasterControl
from db.Db import Db
from db.finance import Finance

__all__ = list()

#===============================================================================
# MasterControlFinance (concrete)
#===============================================================================

__all__ += ['MasterControlFinance']
class MasterControlFinance(MasterControl):

    # constructor
    def __init__(self):
        MasterControl.__init__(self)

    # must implement        
    def originalToEssence(self, orig):
        essence = Finance.Essence(orig)
        return essence
    
    # must implement        
    def essenceToModel(self, essence):
        model = Finance.Model(essence)
        return model

    # must implement        
    def collectOriginals(self):
        
        folder_beyond_banking = \
        "/data/kurt/Documents/institutions/original/ml-beyondbanking/downloaded2016-07-19" 
                    
        folder_joint_beyond_banking = \
        "/data/kurt/Documents/institutions/original/ml-jointbb/downloaded2016-03-10"        
    
        mint_capital_one = \
        "/data/kurt/Documents/institutions/original/mint-capital-one/downloaded2016-03-10/transactions.csv"        
    
        mint_chase = \
        "/data/kurt/Documents/institutions/original/mint-chase/downloaded2016-03-10/transactions.csv"        

        # Beyond Banking
        originals = list()
        for directory, subdirectories, files in os.walk(folder_beyond_banking):
            for file in files:
                csv = os.path.join(directory, file)
                orig = Finance.OrigBeyondBanking(csv, Db.CsvFormatStandard)
                if True:
                    print "    Another Beyond Banking:", csv
                    originals.append(orig)

        # Joint Beyond Banking
        for directory, subdirectories, files in os.walk(folder_joint_beyond_banking):
            for file in files:
                csv = os.path.join(directory, file)
                orig = Finance.OrigBeyondBanking(csv, Db.CsvFormatStandard)
                if False:
                    print "    Another Joint:", csv
                    originals.append(orig)

        # Capital One Credit Card    
        orig = Finance.OrigMint(mint_capital_one, Db.CsvFormatStandard)   
        if False: originals.append(orig)
                 
        # Chase Credit Card    
        orig = Finance.OrigMint(mint_chase, Db.CsvFormatStandard)   
        if False: originals.append(orig)

        return originals
        
    # must implement        
    def createViewsOfTheModel(self, model):
        views = list() 
        
        view = Finance.ViewMonth(model);              views.append(view);
        view = Finance.ViewMonthSummary(model);       views.append(view);
        view = Finance.ViewCategory(model);           views.append(view);
        view = Finance.ViewCategorySummary(model);    views.append(view);
        view = Finance.ViewSubCategory(model);        views.append(view);
        view = Finance.ViewSubCategorySummary(model); views.append(view);
        view = Finance.ViewAccounts(model);           views.append(view);
        view = Finance.ViewAccountsSummary(model);    views.append(view);
        view = Finance.ViewStudy(model);              views.append(view);
    
        return views
        
    
    
