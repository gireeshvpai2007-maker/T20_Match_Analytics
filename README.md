# T20 Match Analytics & Penalty Engine

A modular Verilog project for a T20 scoreboard and match-status logic. The individual blocks are connected by the top-level module `t20_match_analytics`.

## Modules

- **Score Aggregator** — accumulates runs on each rising clock edge and counts a wicket once per asserted wicket pulse.
- **Over-Rate Subtractor** — calculates overs remaining and asserts a violation when completed overs exceed allowed overs.
- **Target Comparator** — calculates runs required and indicates when the current score has reached the target. The interface supports 16-bit scores.
- **Penalty Trigger** — produces a penalty flag and code from the over-rate violation, target-reached signal, and wicket count.
- **Display Multiplexer** — selects score, wickets, overs, overs remaining, runs required, or penalty code for the display output.
- **Integrated top module** — `t20_match_analytics.v` wires these blocks together.
- **Integrated testbench** — `t20_match_analytics_tb.v` checks a basic end-to-end scenario.

## Display select values

| `select` | Display output |
|---|---|
| `000` | Total score |
| `001` | Wickets |
| `010` | Completed overs |
| `011` | Overs remaining |
| `100` | Runs required |
| `101` | Penalty code |
| Other values | Zero |

## Run the integrated simulation

Run these commands from the repository root in a terminal with Icarus Verilog installed:

```bash
iverilog -g2012 -s t20_match_analytics_tb -o integrated_tb.vvp t20_match_analytics.v t20_match_analytics_tb.v Score_Aggregator/score_aggregator.v Over-Rate_Subtractor/over_rate_subtractor.v Target_Comparator/target_comparator.v Display_Multiplexer/display_mux.v Penalty_trigger/penalty_trigger.v
vvp integrated_tb.vvp
```

A successful run prints `PASS: integrated T20 Match Analytics tests completed.` and writes `t20_match_analytics_tb.vcd`, which can be opened in GTKWave.

## Run the target comparator tests

```bash
iverilog -g2012 -s target_comparator_tb -o comparator_tb.vvp Target_Comparator/target_comparator.v Target_Comparator/target_comparator_tb.v
vvp comparator_tb.vvp
```

## Important design note

The penalty rule currently follows the existing `penalty_trigger` module: a penalty is asserted only when an over-rate violation and target-reached signal are both high and wickets are fewer than four. Confirm that this rule matches the project specification before presenting it as a real cricket regulation.
