# A Spatiotemporal Epidemic Model to Quantify The Effects of Testing, Contact Tracing and Containment

This repository contains scripts and notebooks to analyze data from San Francisco, CA, USA COVID-19 cases and from a spatiotemporal epidemiology model data with alternations from Stanford Future Bay Initiative [paper](https://arxiv.org/abs/2004.07641). Here, I specifically look at manual contact tracing and the impact it had on Wave 2 of the pandemic. 

## Project description

Manual contact tracing is one of the most heavily invested interventions by counties to combat COVID-19. While in cities like San Francisco, 85% of the individuals who are reached after a positive test respond to a call from a nurse, only 26% of the population provide further contacts to further help with the intervention. I propose to use a prebuilt epidemiology simulator that was developed in collaboration with my research team at Stanford to analyze how increasing the number of contacts provided or the percentage of individuals who provide contacts can significant decrease the spread of the virus. The project will show 

1. 25% of contact tracing with 2 individuals being provided on average is statistically significant in combating the virus; 
2. if more individuals were to provide contacts or more contacts are provided, the decrease in number of infections is statistically significant. 
In order to conduct this project, I will use data from San Francisco COVID-19 case reservoir and the spatiotemporal epidemiology simulator that randomly simulates 40 instances. With the new variants on the rise, manual contact tracing, even more so than automated contact tracing, will be more powerful during winter season outbreaks. For this reason, this project has the potential to be very powerful. For example, if during a phone call, a nurse explains that by providing 3 contacts instead of 2, they can save 20% of potential exposure events, then maybe a positively infected individual will be more likely to provide contacts. 

## Jupyter Notebook with results

For the purposes of this exercise, all preliminary results are in [sim-example-prelim.ipynb](sim/sim-example-prelim.ipynb). These preliminary results suggest that 26% opt-in to provide contacts on average of 2 (as given from SF data), is insignificant. 

<p align="center">
<img width="33%" src="/plots/run0_ex_CT.png">
<img width="33%" src="./plots/run0_ex_noCTpng">
</p>

Thus manual contact tracing is currently only useful to remind people who have tested positive to stay at home. The follow up question is at what percentage opt-in and how many contacts on average will be necessary for manual contact tracing to be an affective intervention beyond promoting individuals who are tested positive to stay at home?

## Research conducted leading up to the analysis above

The Stanford Future Bay Initiative did a grid search for the best transmission value and probability of an individual to stay at home for each Wave of the pandemic. The results for Wave 2 are provided in [plot_bayopt.m](plot/plot_bayopt.m) 

<p align="center">
<img width="33%" src="/plots/BayesOpt_obj.png">
<img width="33%" src="./plots/LR_beta_obj.png">
<img width="33%" src="./plots/LR_p_obj.png">
</p>


## Dependencies

All the experiments were executed using Python 3. In order to create a virtual environment and install the project dependencies you can run the following commands:

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

## Code organization (original text from Lorch)

In the following tables, short descriptions of notebooks and main scripts are given. The notebooks are self-explanatory and execution details can be found within them.

| Notebook              | Description                                                   |
|-----------------------|---------------------------------------------------------------|
| [town-generator.ipynb](sim/town-generator.ipynb)  | Generates population, site and mobility data for a given town. |
| [sim-example.ipynb](sim/sim-example.ipynb)     | Example experiment on the spread of the disease under testing, contact tracing and/or containment measures. |

| Scripts              | Description                                                   |
|-----------------------|---------------------------------------------------------------|
| [calibrate.py](sim/calibrate.py)  | Calibrates the model based on real case data. Run `calibrate.py --help` for help. |


| Modules                | Description                                                   |
|-----------------------|---------------------------------------------------------------|
| [distributions.py](sim/lib/distributions.py) | Contains COVID-19 constants and distribution sampling functions. |
| [town_data.py](sim/lib/town_data.py)  | Contains functions for population and site generation. |
| [data.py](sim/lib/data.py)   | Contains functions for COVID-19 data collection. |
| [mobilitysim.py](sim/lib/mobilitysim.py) | Produces a **MobilitySimulator** object for generating mobility traces. |
| [dynamics.py](sim/lib/dynamics.py) | Produces a **DiseaseModel** object for simulating the spread of the disease. |
| [parallel.py](sim/lib/parallel.py) | Contains functions used for simulations on parallel threads. |
| [measures.py](sim/lib/measures.py) | Produces a **Measure** object for implementing intervention policies. |
| [inference.py](sim/lib/inference.py) | Contains functions used for Bayesian optimization. |
| [plot.py](sim/lib/plot.py) | Produces a **Plotter** object for generating plots. |
| [town_maps.py](sim/lib/plot.py) | Produces a **MapIllustrator** object for generating interactive maps. |


## Citation for the simulation 

If you use parts of the code in this repository for your own research purposes, please consider citing:

    @article{lorch2020spatiotemporal,
        title={A Spatiotemporal Epidemic Model to Quantify the Effects of Contact Tracing, Testing, and Containment},
        author={Lars Lorch and William Trouleau and Stratis Tsirtsis and Aron Szanto and Bernhard Sch\"{o}lkopf and Manuel Gomez-Rodriguez},
        journal={arXiv preprint arXiv:2004.07641},
        year={2020}
    }
