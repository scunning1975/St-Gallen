# St. Gallen Causal Panel Methods Workshop 2025

Welcome to the materials for the **St. Gallen Causal Panel Methods Workshop**, a weeklong intensive course (10:15–12:00 & 14:15–16:00 daily) held at the University of St. Gallen from **June 30 to July 4, 2025**. We focus on estimation, interpretation, application, and troubleshooting of cutting-edge causal inference methods for panel data.

---

## About the Workshop

This workshop is a sequel to previous courses on panel methods and is designed for researchers ready to deepen their understanding of modern techniques for causal inference in panel settings. We will cover:

* Difference-in-Differences (DiD)
* Violations of parallel trends and use of covariates
* Event studies, leads/lags, and triple differences
* Differential timing (GxT) and decomposition methods (e.g., Bacon, CS, SA)
* Imputation estimators (e.g., Borusyak et al.)
* Continuous DiD (DxT) and synthetic control (if time permits)
* Practical implementation, checklists, and interpretation issues

You will replicate recent empirical papers and work on your own applied project. This workshop builds both coding fluency and conceptual clarity.

---

## Assignments & Evaluation

There are 31 students registered for the course, and 13 are taking the exam. Evaluation is based on three components:

1. **Daily Podcasts**: Each day there will be a podcast assigned for listening. You do not need to turn in write-ups daily, but all podcast reflections will be due alongside the final exam.
2. **Coding Exercise**: This will be conducted together in class on the final day (Friday, July 4).
3. **Final Exam**: This is a take-home exam, due by **August 13**, submitted via Canvas. The exam will be made available shortly after the course ends. Grades (pass/fail for PhD students) must be submitted by August 15.

---

## Workshop Schedule Overview

**Daily Time Block (Monday through Friday)**

* Morning Lecture: 10:15–12:00
* Lunch at Cafeteria: 12:00–13:00
* Afternoon Lecture: 14:15–16:00

### Monday, June 30: Core DiD and Simple Violations

* 2x2 DiD: Four averages, three subtractions
* Potential outcomes framework and ATT
* Three-regression equivalence
* Population weighting in 2x2 DiD
* Introduction to event studies and falsification strategies

### Tuesday, July 1: Parallel Trends, Covariates, and 2xT

* Repeated cross sections and compositional changes
* Conditional parallel trends and selection on observables
* Imputation vs MAR
* Estimation methods: IPW, OR, DR, TWFE with covariates
* Diagnostics: PS score balance, NDIM

### Wednesday, July 2: Differential Timing (GxT)

* Bacon decomposition of TWFE
* Callaway & Sant’Anna: ATT(g,t) and interpretation
* Event studies using both long differences and short gaps
* Sun & Abraham decomposition

### Thursday, July 3: Checklist Design and Research Examples

* Real-world GxT example from current research
* Imputation estimator: Borusyak, Jaravel, and Spiess
* Building a diagnostic checklist for your project

### Friday, July 4: Continuous DiD (DxT) and More

* Continuous treatment: Estimation, interpretation, and issues
* Replication: Abortion clinic closures as DxT case
* (If time) Intro to synthetic control
* In-class coding exercise

---

## Logistics and Locations

* **Address**: House Washington, Rosenbergstrasse 20–22, 9000 St. Gallen
* **Lecture Room**: 83-2229 in House Washington
* **Office Space**: Room 83-2217 (Scott Cunningham)
* **Cafeteria**: Rosenbergstrasse 59 (group walk daily at 12:00)
* **Guest Card**: Provided on Monday to access building areas

### Events

* **Monday 4:00 PM**: Welcome Apero in Break Room (House Washington)
* **Wednesday 4:30–6:30 PM**: Bilateral Meetings (sign up with Sam)
* **Wednesday 7:00 PM**: Faculty Dinner
* **Friday 4:00 PM**: Farewell Drink @ Restaurant Brauwerk (across from House Washington)

---

## Repository Structure

* `/data/` — Sample datasets
* `/labs/` — Stata and R code
* `/notes/` — Misc. notes
* `/references/` — Papers and readings
* `/slides/` — Updated lecture slides (redownload each day)

GitHub Repository: [https://github.com/scunning1975/St-Gallen](https://github.com/scunning1975/St-Gallen)

Canvas Course Page (HSG login required): [https://learning.unisg.ch/courses/22479](https://learning.unisg.ch/courses/22479)

---

## Who Should Attend?

Doctoral students or early-stage researchers using diff-in-diff methods seeking to:

* Understand key identification assumptions
* Learn how modern estimators adjust for violations
* Gain fluency with applied implementation
* Troubleshoot strange or contradictory findings

---

## Tools Used

* **Stata**: `csdid`, `drdid`, `eventstudyinteract`
* **R**: `did`, `fixest`, `synth`, `honestdid`
* **Google Sheets** (for shared exercises)

Comfort with basic panel data regressions is assumed. Prior DiD experience is not.

---

## Optional Reading List

* Cunningham (2021), *Causal Inference: The Mixtape*
* Baker et al. (2025), *Working Paper*
* Callaway & Sant’Anna (2021), *JoE*
* Goodman-Bacon (2021), *JoE*
* Sun & Abraham (2021), *JoE*
* de Chaisemartin & D'Haultfœuille (2020), *AER*
* Borusyak et al. (2024), *Restud*
* Roth & Rambachan (2023), *Honest DiD*
* Callaway, Goodman-Bacon & Sant’Anna (2025), *AER R\&R*

See `/references/` for more.

---

## License

MIT License. All materials are open for educational use.

---

## Questions?

Use [GitHub Issues](https://github.com/scunning1975/St-Gallen/issues) or contact Scott Cunningham directly.
