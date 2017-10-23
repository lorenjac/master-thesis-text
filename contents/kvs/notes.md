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
    * in production (e.g. big-data): redis, memcached, berkeley db, aerospike
    * in research: berkeley db, echo, nvht, nvmcached
    * databases, caches, file systems
* aspects
    * distributed vs local
    * in-memory vs disk-based
    * transactions vs atomic operations
    * data structures (/memory management)
        * b-tree
            * classic (berkeley db)
            * master-tree (foedus)
            * cdds
        * hash table (redis, memcached, berkeley db, echo, nvht)
        * LSM-tree (atlas for baidu)
        * radix tree (lee2017wort)
    * optimization
        * Kernel Modules: waddington2014scalable (Fiasco), xu2014building (Linux)
        * GPU: hetherington2012characterizing, zhang2015mega_kv
        * SIMD: lemire2017upscaledb
        * RDMA: mitchell2013using, wang2015hydradb, hemmatpour2016kanzi

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
        * multi-core processors become affordable (area, power, architecture)
        * vectorization not really an option
* problem
    * data races in shared memory (RW, WR, WW)
    * => need synchronization (emulate serial execution)
        * ensure consistency, recover when in doubt
    * **problem**: concurrency introduces synchronization overhead
        * a) do not provide concurrency (rely on fast memory + eliminate recovery)
        * b) relax consistency requirements (serializability may not be needed)
        * c) design efficient concurrency control (e.g. optimistic CC => MVCC)
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
        * serializable snapshot isolation (track read-sets for modification)
            * neumann2015fast
            * faleiro2015rethinking
            * ding2015centiman
            * wang2017efficiently
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
