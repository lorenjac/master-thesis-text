# A Key-Value Store with Serializable Transactions for NVRAM

## Introduction

* DBs are important (=> we want to increase throughput)
    * MMDBs
    * concurrent transactions (=> ensure serializability)
* KVS are important
    * used at notorious internet companies
    * simple database without overhead
    * often implemented as MMDB
* most KVS (esp. for NVRAM) do not support or encourage serializability
    * too costly
    * 'not necessary'
* NVRAM
    * overview
* using NVRAM could make serializability affordable
* task
    * implement a key-value store for NVRAM
    * support optimized serializability
* overview

## Non-Volatile RAM

* definition
* properties
* applications

### Persistence

* OS no longer manages persistence through page caches (HW is in charge)
* HW is unaware of transactional semantics
* need to enforce persistence (in case of power loss)
    * fences
    * cacheline flushes
    * write-pending queue flushes (former PCOMMIT, now ADR)

### Phase-Change Memory

* definition
* description
* example

## Key-Value Stores

* definition

### Design

* properties
* architectures
    * API
    * in-memory/disk
    * local/distributed
    * (non-)transactional
    * single-/multithreaded
    * recovery

### Serializability

* definition
* examples
* multiversioning
    * original, reed1978
    * snapshot isolation, berenson1995
    * read-only anomaly, fekete2004
    * dep graphs, cahill2009
    * fast range scans, neumann2015
    * predef r/w sets, faleiro2015
    * concurrent validation, ding2015
    * serializing on-top layer, fekete2017

## Designing a Key-Value Store for NVRAM
### Design Considerations
### Concurrency Control
### Existing Designs

## Design

## Implementation

## Evaluation

## Conclusions