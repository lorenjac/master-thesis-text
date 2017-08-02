## Key Value Stores

* what
    * simple database
    * associative collection
* why
    * light-weight
    * easier to study than full-scale DBS
        * primitive data
        * small interface
        * no query language
* applications
    * in production (e.g. big-data): redis, memcached, berkeley db, atlas (for baidu)
    * in research: foedus, nvht, echo, berkeley db
* aspects
    * storage
        * topologies
            * read
        * memory management
        * data structures
            * b-tree
                * classic (berkeley db)
                * master-tree (foedus)
                * cdds
            * LSM-tree (atlas for baidu)
            * hash table (redis, memcached, berkeley db, echo, nvht)
            * radix tree (lee2017wort)
    * transactions
        * atomicity
        * consistency
        * isolation
        * durability

### Transactions

* what
    * sequence of operations with all-or-nothing semantics
* properties
    * ACID
* applications
    * finance
    * ecommerce
    * healthcare
    * big data (A.I.)
* types
    * flat
    * nested
    * distributed
* implementation
    * software transactions
        * bound to specific data structures (not raw memory)
        * only designated data is handled transactionally
        * software-emulated operations
    * transactional memory (STM, HTM)
        * transactional semantics for memory access
        * compiler ensures transactional semantics for marked regions
        * every (!) memory access is monitored => expensive

### Concurrency

* why
    * can improve throughput
    * can improve resource utilization
* problem
    * data races in shared memory
    * => need serializability (emulate serial execution)
* locking
    * block (wait) upon request to occupied resource until resource available
    * granularities
        * row/column
        * page
        * table
        * database
    * primitives
        * MS: critical section, semaphores (mutex)
        * Linux: spinlocks, semaphores (mutex), big-kernel-lock
    * algorithms: two-phase locking (acquire, release)
* mvcc
    * origin: reed '78, distributed systems
    * fields
        * (in-memory) databases, KV-Stores
        * transactional memory
    * concept
        * readers never wait
        * writers do not update in-place
        * versions/timestamps
        * visibility
        * validation
        * optimism
        * garbage collection
    * impl
        * usually optimistic (except for ORACLE Read Consistency [may be deprecated])
            * faster than pessimistic (larson2011high)
        * issues
            * data structures (locked, lock-free data structures)
            * timestamp creation (locked, atomic fetch-and-add)
            * timestamp update (locked, atomic test-and-set)
        * snapshot isolation (write skew, read-only anomaly)
        * serializable snapshot isolation (track read-sets to know if version was written after read)
        * neumann2015fast
    * related: RCU
        * restricted form of MVCC (2VCC, only one item => no dependencies)
        * used in operating systems (linux, dragonflyBSD)
        * often used to eliminate expensive kernel locks (=> eliminates waiting)

### Durability

* what is that and why do we need it:
    * ACID requires durability and consistency
    * => need recovery in case of crash or transaction failure
* basic mechanisms:
    * write-ahead logging (e.g. ARIES)
    * checkpointing (to reduce undos/redos)
* eliminated in some MMDB (SOFORT)
    * delta/main-partitioning (quasi RCU / shadow copying)

## Non-Volatile Memory

* new class of main memory (storage-class memory)
* byte-addressable
* fast
* dense
* inexpensive

### Implications

* storage no longer block-oriented => new algorithms/data structures possible/needed
* several possible topologies
    * replace disk (faster "disk")
    * complement DRAM (fast enough to accompany DRAM, may decide what data is persistent)
    * replace DRAM: main memory becomes storage => less/no disk IO (everything is persistent)
* consistency issues in case of power loss
    * memory models ? (+ relaxations ?)
    * fences + flushes
    * PCOMMIT (dedicated CPU instruction; deprecated)
    * ADR (asynchronous DRAM refresh, platform-dependent, PCOMMIT replacement)
    * whole-system persistence (interrupt + flush on powerloss)

### Technologies

* PCM, 3D XPoint, MRAM, RRAM, ...
* performance => write -10 %, read -5 %
* wear => need wear leveling

### Simulation

* not yet commercially available => need to simulate
* latency
    * program SPD
    * encapsulate mem access + insert NOPs (rdtsc, clock_gettime())
* powerloss
    * signals: `raise(SIGKILL)`, `raise(SIGSTOP)`
    * exit: `std::quick_exit()`, `std::_Exit()`
* durability
    * RAM disk
    * tmpfs
* WHISPER benchmark
