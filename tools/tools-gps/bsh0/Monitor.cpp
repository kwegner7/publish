//************************************************************************
//                 ***  LOCAL NAMESPACE ***
//************************************************************************
namespace
{
    class MonitorPaths
    {
        class Path
        {
            private:
                const Arch::string title1;
                const Arch::string title2;
                unsigned count;
        };

        enum PathName
        {
            lpushing_real,
            lpushing_sim,
            lout_of_sync,
            ltrimming_sims,
            lmeasurements_missing,
            lsim_id_999,
            lpushing_real_or_first_of_pair,
            lpushing_second_of_pair,
            lsingle_received,
            lpair_second_received,
            lpair_first_received,
            lcorrelates_true,
            lcorrelates_false,
            lprocess_returns_true,
            lprocess_returns_false,
            ldiscard_corrupted
        };

        Arch::Map<PathName, Path> all_paths;

        private:
            unsigned pushing_real;
            unsigned pushing_sim;
            unsigned out_of_sync;
            unsigned trimming_sims;
            unsigned measurements_missing;
            unsigned sim_id_999;
            unsigned pushing_real_or_first_of_pair;
            unsigned pushing_second_of_pair;
            unsigned single_received;
            unsigned pair_second_received;
            unsigned pair_first_received;
            unsigned correlates_true;
            unsigned correlates_false;
            unsigned process_returns_true;
            unsigned process_returns_false;
            unsigned discard_corrupted;

        public:
            void pushingReal()                { this->pushing_real++;                   this->report(); }
            void pushingSim()                 { this->pushing_sim++;                    this->report(); }
            void outOfSync()                  { this->out_of_sync++;                    this->report(); }
            void trimmingSims()               { this->trimming_sims++;                  this->report(); }
            void measurementsMissing()        { this->measurements_missing++;           this->report(); }
            void simId999()                   { this->sim_id_999++;                     this->report(); }
            void pushingRealOrFirstOfPair()   { this->pushing_real_or_first_of_pair++;  this->report(); }
            void pushingSecondOfPair()        { this->pushing_second_of_pair++;         this->report(); }
            void singleReceived()             { this->single_received++;                this->report(); }
            void pairSecondReceived()         { this->pair_second_received++;           this->report(); }
            void pairFirstReceived()          { this->pair_first_received++;            this->report(); }
            void correlatesTrue()             { this->correlates_true++;                this->report(); }
            void correlatesFalse()            { this->correlates_false++;               this->report(); }
            void processReturnsTrue()         { this->process_returns_true++;           this->report(); }
            void processReturnsFalse()        { this->process_returns_false++;          this->report(); }
            void discardCorrupted()           { this->discard_corrupted++;              this->report(); }

        public:
            const Arch::string
            asString() const
            { 
                Arch::ostringstream msg;
                msg
                    << setw(7) << this->pushing_real
                    << setw(7) << this->pushing_sim
                    << setw(7) << this->out_of_sync
                    << setw(7) << this->trimming_sims
                    << setw(7) << this->measurements_missing
                    << setw(7) << this->sim_id_999
                    << setw(7) << this->pushing_real_or_first_of_pair
                    << setw(7) << this->pushing_second_of_pair
                    << setw(7) << this->single_received
                    << setw(7) << this->pair_second_received
                    << setw(7) << this->pair_first_received
                    << setw(7) << this->correlates_true
                    << setw(7) << this->correlates_false
                    << setw(7) << this->process_returns_true
                    << setw(7) << this->process_returns_false
                    << setw(7) << this->discard_corrupted
                    << "\n";
                return msg.str();
            }

        private:
            MonitorPaths()
            :
                pushing_real(0),
                pushing_sim(0),
                out_of_sync(0),
                trimming_sims(0),
                measurements_missing(0),
                sim_id_999(0),
                pushing_real_or_first_of_pair(0),
                pushing_second_of_pair(0),
                single_received(0),
                pair_second_received(0),
                pair_first_received(0)
            {}

        public:
            static MonitorPaths&
            theMonitor()
            {
                static MonitorPaths& k = *new MonitorPaths();
                return k;
            }

        public:
            void
            report() const
            {
                static unsigned counter(0);
                if (false && (counter++)%100 == 0)
                {
                    ACE_DEBUG
                    ((
                        LM_ERROR,
                        theMonitor().asString().c_str()
                    ));
                }
            }

      }; // class MonitorPaths
} // namespace

//************************************************************************
//                 ***  LOCAL NAMESPACE ***
//************************************************************************
namespace
{
    class MonitorPaths
    {
        private:
            unsigned count_inputs;                    // counters 
            unsigned count_sim_low;
            unsigned count_sim_high;
            unsigned count_real_low;
            unsigned count_real_high;

            unsigned reject_no_detections;
            unsigned reject_too_old;
            unsigned discard_que_full;
            unsigned discard_sim_low_priority;
            unsigned discard_sim_high_priority;
            unsigned discard_real_low_priority;
            unsigned discard_real_high_priority;
            unsigned accept_sim_low;
            unsigned accept_sim_high;
            unsigned accept_real_low;
            unsigned accept_real_high;

            unsigned que_size;                        // constants
            unsigned thresh_sim_low;
            unsigned thresh_sim_high;
            unsigned thresh_real_low;
            unsigned thresh_real_high;

        public:
            void countInputs()              { this->count_inputs++;                } // this->report(); }
            void countSimLow()              { this->count_sim_low++;               } // this->report(); }
            void countSimHigh()             { this->count_sim_high++;              } // this->report(); }
            void countRealLow()             { this->count_real_low++;              } // this->report(); }
            void countRealHigh()            { this->count_real_high++;             } // this->report(); }

            void rejectNoDetections()       { this->reject_no_detections++;        } // this->report(); }
            void rejectTooOld()             { this->reject_too_old++;              } // this->report(); }
            void discardQueFull()           { this->discard_que_full++;            } // this->report(); }
            void discardSimLowPriority()    { this->discard_sim_low_priority++;    } // this->report(); }
            void discardSimHighPriority()   { this->discard_sim_high_priority++;   } // this->report(); }
            void discardRealLowPriority()   { this->discard_real_low_priority++;   } // this->report(); }
            void discardRealHighPriority()  { this->discard_real_high_priority++;  } // this->report(); }
            void acceptSimLow()             { this->accept_sim_low++;              } // this->report(); }
            void acceptSimHigh()            { this->accept_sim_high++;             } // this->report(); }
            void acceptRealLow()            { this->accept_real_low++;             } // this->report(); }
            void acceptRealHigh()           { this->accept_real_high++;            } // this->report(); }

            void reportQueSize(const unsigned& value)        { this->que_size = value;        }
            void reportThreshSimLow(const unsigned& value)   { this->thresh_sim_low = value;  }
            void reportThreshSimHigh(const unsigned& value)  { this->thresh_sim_high= value;  }
            void reportThreshRealLow(const unsigned& value)  { this->thresh_real_low = value; }
            void reportThreshRealHigh(const unsigned& value) { this->thresh_real_high= value; }

        public:
            const Arch::string
            asString() const
            { 
                Arch::ostringstream msg;
                msg

                    << " SL"
                    << setw(7) << this->count_sim_low
                    << setw(7) << this->discard_sim_low_priority
                    << setw(7) << this->accept_sim_low
                    << setw(7) << this->thresh_sim_low

                    << " SH"
                    << setw(7) << this->count_sim_high
                    << setw(7) << this->discard_sim_high_priority
                    << setw(7) << this->accept_sim_high
                    << setw(7) << this->thresh_sim_high

                    << " RL"
                    << setw(7) << this->count_real_low
                    << setw(7) << this->discard_real_low_priority
                    << setw(7) << this->accept_real_low
                    << setw(7) << this->thresh_real_low

                    << " RH"
                    << setw(7) << this->count_real_high
                    << setw(7) << this->discard_real_high_priority
                    << setw(7) << this->accept_real_high
                    << setw(7) << this->thresh_real_high

                    << " IN/FULL"
                    << setw(7) << this->count_inputs
                    << setw(7) << this->discard_que_full

                    << " REJECT"
                    << setw(7) << this->reject_no_detections
                    << setw(7) << this->reject_too_old
 
                    << setw(7) << this->que_size
                    << "\n";
                return msg.str();
            }

        private:
            MonitorPaths()
            :
                count_inputs(0),
                count_sim_low(0),
                count_sim_high(0),
                count_real_low(0),
                count_real_high(0),

                reject_no_detections(0),
                reject_too_old(0),
                discard_que_full(0),
                discard_sim_low_priority(0),
                discard_sim_high_priority(0),
                discard_real_low_priority(0),
                discard_real_high_priority(0),
                accept_sim_low(0),
                accept_sim_high(0),
                accept_real_low(0),
                accept_real_high(0),

                que_size(0),
                thresh_sim_low(0),
                thresh_sim_high(0),
                thresh_real_low(0),
                thresh_real_high(0)
            {}

        public:
            static MonitorPaths&
            theMonitor()
            {
                static MonitorPaths& k = *new MonitorPaths();
                return k;
            }

        public:
            void
            report() const
            {
                static unsigned counter(0);
                if ((counter++)%100 == 0)
                {
                    ACE_DEBUG
                    ((
                        LM_ERROR,
                        theMonitor().asString().c_str()
                    ));
                }
            }

      }; // class MonitorPaths
} // namespace


      ::MonitorPaths::theMonitor().discardQueFull();
      ::MonitorPaths::theMonitor().reportQueSize(unprocessedRadarReturns);


