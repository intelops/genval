# OpenTelemetry Integration with Qwickwit

This document outlines the integration of OpenTelemetry (OTel) within the Genval, which is designed to facilitate the collection of logs, traces, and metrics. The core integration logic resides in the `PersistantPreRunE()` function of the `rootCmd()`, enabling the application to capture spans across all child commands. Spans are concluded appropriately in the `cobra.OnFinalize()` method during the initialization of `rootCmd()`.

## Key Functions and Trace Transmission

Several critical functions are responsible for validating resources and facilitating communication with the LLM backend for the `genai` command. These functions are integral to transmitting trace spans effectively.

## TODO: Additional functions for transmitting traces and logs need to be incorporated.

## Current Implementation Overview
The existing implementation integrates OTel with [*Quickwit*](https://quickwit.io/docs) to store and visualize traces and logs. The tracing and logging data is exported via a *gRPC* client to the OTel Collector on port 4317, which subsequently forwards this data to Quickwit. For detailed integration steps, refer to the [Quickwit documentation](https://quickwit.io/docs/distributed-tracing/send-traces/using-otel-collector). The configuration file for the OTel Collector (YAML format) is located in the root directory of this project.

To initiate the Quickwit instance, it is necessary to install the Quickwit CLI and execute it using the command `quickwit run`. Following this, a Docker container for the OTel Collector should be spun up. Once these steps are completed, traces and logs can be accessed through the Quickwit backend at `localhost:7280`.

## TODO: Update the workflow for running the Quickwit instance using Docker Compose.
