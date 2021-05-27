---------------------- MODULE AsyncTerminationDetection_proof ---------------------
EXTENDS AsyncTerminationDetection, TLAPS

(* Whitelist all the known facts/assumptions and definitions *)
USE NIsPosNat DEF vars, terminated, Node,
                  Init, Next, Spec,
                  DetectTermination, Terminate,
                  Wakeup, SendMsg,
                  TypeOK, Stable

\* * An invariant I is inductive, iff Init => I and I /\ [Next]_vars => I. Note
\* * though, that TypeOK itself won't imply  Stable  though!  TypeOK alone
\* * does not help us prove Stable.

\* TODO Prove  TypeOK  inductive.
LEMMA TypeCorrect == Spec => []TypeOK
<1>1. Init => TypeOK BY NIsPosNat DEF Init, TypeOK, Node, terminated
<1>2. TypeOK /\ [Next]_vars => TypeOK'
 <2> SUFFICES ASSUME TypeOK,
                     [Next]_vars
              PROVE  TypeOK'
   OBVIOUS
 <2>1. CASE DetectTermination
   BY <2>1
 <2>2. ASSUME NEW i \in Node,
              NEW j \in Node,
              Terminate(i)
       PROVE  TypeOK'
   BY <2>2
 <2>3. ASSUME NEW i \in Node,
              NEW j \in Node,
              Wakeup(i)
       PROVE  TypeOK'
   BY <2>3
 <2>4. ASSUME NEW i \in Node,
              NEW j \in Node,
              SendMsg(i, j)
       PROVE  TypeOK'
   BY <2>4
 <2>5. CASE UNCHANGED vars
   BY <2>5
 <2>6. QED
   BY <2>1, <2>2, <2>3, <2>4, <2>5 DEF Next
<1>. QED BY <1>1, <1>2, PTL

=============================================================================