# On-Chain Oracle Project for api call

Welcome to the **On-Chain Oracle** project! This project provides an oracle service on the Internet Computer that fetches external price data at regular intervals, stores it as a time series, and makes it accessible via query calls. The backend service is built in Motoko, while the frontend is developed with React.

## Project Overview

The **On-Chain Oracle** fetches data from external sources (e.g., the Coinbase API) using HTTP outcalls, processes it on-chain, and stores the results. This project is intended to demonstrate real-time data fetching and storage on the Internet Computer, making the data available for applications that need dynamic, updated information.

## Directory Structure

- **`src/`**: Contains both backend and frontend code.
  - **`backend/`**: A Motoko-based canister that handles data fetching, processing, and storage of the fetched time series data.
  - **`frontend/`**: A React-based user interface for viewing and querying the latest stored data.
- **`dfx.json`**: Configuration file defining the canister settings.
- **`package.json`**: Specifies dependencies and scripts for frontend development.

## Prerequisites

- **DFX (Dfinity SDK)**: Install by following the [DFX installation guide](https://internetcomputer.org/docs/current/developer-docs/setup/install).
- **Node.js**: Required for frontend development.

## Quick Start Guide
