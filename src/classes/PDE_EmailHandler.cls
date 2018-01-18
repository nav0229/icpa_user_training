/*
    PDEEmailHandler.cls
    Inbound email handler class that will accept an email and create an associated PDE Case calling classes within PDE Helper
    -------------------------------------------------------------------
       Date        Version  Description
    -------------------------------------------------------------------
       10/6/2017  1.0.0    Creation

*/
global class PDE_EmailHandler implements Messaging.InboundEmailHandler
{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope)
    {
     
     return PDEHelper.handleInboundEmail(email, envelope);

    }
}