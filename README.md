# Ancillary Services No Pay Pass Through Tool
This easy to use tool was created to be able to automatically calculate and pass Ancillary Service No-Pay/Non-Compliance penalties to third-party power plants for charges that they were specifically liable for. Our team did not charge the third-party the entire penalty, instead I used raw CAISO bill determinant data and rebuilt the CAISO's Ancillary Services penalty calculations for the actions that third-party were solely responsible for.

The tool was written with Excel VBA, due to the department analysts' comfort with Excel, and the data was extracted and transformed from an Oracle database with SQL.

## Files
AS No Pay Pass Through Macro.xlsm - Complete VBA tool.
AS No Pays-CTEUpdate.sql - SQL code used in the tool.
Pass Through Tool VBA Code - Complete code for the VBA Tool, includes SQL implementation.

## Quick View of UI
![asnopaytool](../master/AS%20No%20Pay.png)

## Overview of Operating Reserve and Regulation Ancillary Services No-Pay/Non-Compliance
### Operating Reserve (Spin/Non-Spin) 
The No Pay Charge for Spinning and Non-Spinning Reserve Settlement rescinds Day Ahead and Real-Time Reserve Capacity Awards payments for the service to the extent that the resource awarded the Reserve Capacity does not fulfill the requirements associated with that payment.  The Spinning and Non-Spinning No Pay rescinds Spinning and Non-Spinning capacity payment when one of the following conditions occurs:
    • AS capacity is undispatchable due to Outage, de-rate, or Ramp Rate limitation
    • AS capacity is unavailable due to Uninstructed Deviations
    • A Generating Unit failed to deliver Energy from an accepted AS Dispatch Instruction.  
    • AS Dispatch Instruction was declined for a System resource in the Automated Dispatch System (ADS)
The requirements dictate that the resource awarded the Spinning and Non-Spinning Reserve capacity payment must either convert that capacity into Energy if dispatched in Real-Time or keep that capacity unloaded and available for a potential dispatch for Energy in Real-Time.  If the resource fails to fulfill these requirements, then it is not entitled to its full AS Reserve Capacity payment. 

### Regulation Non Compliance (No Pay)
The Non Compliance Charge for Regulation Up and Down Settlement rescinds full or partial payments for Day Ahead and Real-Time Regulation Up and Down Capacity Awards payments to the extent that the resource awarded the Regulation Up and Down Capacity does not fulfill the requirements associated with that payment.
Regulation Non-Compliance Charges apply when any one of the following criteria are met:
    • Unit is Off Automatic Generation Control (AGC) control
    • Unit has constrained limit that does not support Regulation range
    • Unit is operating out of Regulating range
    • Unit is operating with telemetry and control communication error
If any of the above conditions occur, then resource is not entitled to its full Regulation Up and Down Capacity payment.  
