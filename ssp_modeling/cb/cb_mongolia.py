# Load packages
from costs_benefits_ssp.cb_calculate import CostBenefits
import pandas as pd
import os

# Define paths
SSP_RESULTS_PATH = "/home/fabian_fuentes/repos/ssp_mongolia/ssp_modeling/ssp_run/"

# Load data
ssp_data = pd.read_csv(os.path.join(SSP_RESULTS_PATH, "sisepuede_results_sisepuede_mongolia_run.csv"))
att_primary = pd.read_csv(os.path.join(SSP_RESULTS_PATH, "ATTRIBUTE_PRIMARY.csv"))
att_strategy = pd.read_csv(os.path.join(SSP_RESULTS_PATH, "ATTRIBUTE_STRATEGY.csv"))
strategy_code_base = "PFLO:BAU"

# Instantiate CostBenefits object
cb = CostBenefits(ssp_data, att_primary, att_strategy, strategy_code_base)

# The export_db_to_excel method saves the initial configuration of the cost tables to an excel file.
# Each sheet represents a table in the cost and benefit program database.
# If the Excel file name is not given, the file will be saved with the default name cb_config_params.xlsx on the current python session.

CB_DEFAULT_DEFINITION_PATH = "/home/fabian_fuentes/repos/ssp_mongolia/ssp_modeling/cb/cb_factores_costo"
CB_DEFAULT_DEFINITION_FILE_PATH = os.path.join(CB_DEFAULT_DEFINITION_PATH, "cb_config_params.xlsx")

cb.export_db_to_excel(CB_DEFAULT_DEFINITION_FILE_PATH)


# Once that the excel file has been updated, we can reload it in order to update the cost factors database
cb.load_cb_parameters("/home/fabian_fuentes/repos/ssp_mongolia/ssp_modeling/cb/cb_factores_costo/cb_config_params.xlsx")

# Compute System Costs
results_system = cb.compute_system_cost_for_all_strategies()

# Compute Technical Costs
results_tx = cb.compute_technical_cost_for_all_strategies()

# Combine results
results_all = pd.concat([results_system, results_tx], ignore_index = True)

#-------------POST PROCESS SIMULATION RESULTS---------------
# Post process interactions among strategies that affect the same variables
results_all_pp = cb.cb_process_interactions(results_all)

# SHIFT any stray costs incurred from 2015 to 2025 to 2025 and 2035
results_all_pp_shifted = cb.cb_shift_costs(results_all_pp)

# Save the results
results_all_pp_shifted.to_csv("/home/fabian_fuentes/repos/ssp_mongolia/ssp_modeling/cb/cb_resultados/cost_benefit_results_tornado.csv", index = False)