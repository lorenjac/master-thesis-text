* intro
    * new class of non-volatile memory
    * hold data even in absence of power
        * earlier versions relied on battery-power
    * due to its parameters suggested as alternative to DRAM
    * not yet commercially available
        * multiple technologies are being researched
    * variety of integration schemes
    * variety of benetifing applications
    * also brings new problems, challenges
* properties
    * byte-addressable (random access memory => RAM)
        * data can addressed on a bytewise granule (not blocks!)
        * but cpus may still fetch an entire cache line (multiple loads!)
            * Haswell: 2 x 32B loads (AVX) + 1 x 32B store per cycle
        * operating systems may fetch entire page
    * non-volatile
        * data survives power loss
        * non-volatile may not be the same as persistence
            * non-volatile = persistent - robustness (redundancy)
            * even if ECC RAM was non-volatile, would not be persistent
* technologies
    * phase-change memory (PCM)
    * magnetoresistive RAM (MRAM)
    * Intel/Micron 3D XPoint
    * STT-RAM
    * RRAM
* general factors
    * access speed vs. capacity (memory hierarchy problem)
    * capacity vs. power consumption (esp. in large computing centers)
* application
    * cache between disks and dram
    * replace disks
    * complement dram
    * replace dram
* beneficiaries
    * high-performance computing, exascale computing
    * databases
        * transaction processing (esp. in disk-based databases)
            * much faster access
        * recovery (esp. in main-memory databases)
            * instant restarts (no database fetch required)
            * faster pre-recovery (logs, checkpoints, versions,...)
    * operating systems (bailey2011)
        * persistent processes (toggle on/off)
    * more exotic applications
        * non-volatile RAM for in-memory machine learning (fumarola2016)
* challenges
    * durability of data no longer controlled by operating systems
        * hardware is unaware (out-of-order exec, store buffers, caches, mcs)
        * need to force durability (fences, cache line flushes, PCOMMIT/ADR)
            * with growing hardware buffers (store buffers, inst queues): fencing becomes more expensive
            * with growing caches: flushing becomes more expensive
    * write speeds may not be as high as with dram (for some techs)
    * wear leveling
    * memory management
        * virtual memory
        * deallocation
    * block-oriented legacy
    * security (sensitive data)
