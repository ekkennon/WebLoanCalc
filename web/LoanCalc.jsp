<%-- 
    Document   : LoanCalc
    Created on : Jan 18, 2017, 5:14:44 PM
    Author     : Erin K Kennon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="business.Loan"%>
<%@page import="java.text.NumberFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Loan Results</title>
    </head>
    <body>
        <h1>Monthly Loan Schedule</h1>
        
        <%
            try {
            double p = Double.parseDouble(request.getParameter("prinbal"));
            double r = Double.parseDouble(request.getParameter("intrate"));
            int t = Integer.parseInt(request.getParameter("term"));
            
            Loan loan = new Loan(p,r,t);
            
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
            NumberFormat percentFormat = NumberFormat.getPercentInstance();
            percentFormat.setMaximumFractionDigits(2);
        %>
        
        <p>
            A payment of <%=currencyFormat.format(loan.getMonthlyPayment())%> is required to pay off a loan of <%=currencyFormat.format(loan.getPrincipal())%> in <%=loan.getTerm()%> months at a rate of <%=percentFormat.format(loan.getRate())%>.
        </p>
        
        <table border="1">
            <tr>
                <th>
                    Month
                </th>
                <th>
                    Beginning Balance
                </th>
                <th>
                    Interest Charged
                </th>
                <th>
                    Principal Amount
                </th>
                <th>
                    Ending Balance
                </th>
            </tr>
            <%
                for (int i=1;i<=loan.getTerm();i++) {
            %>
            <tr>
                <th align="right">
                    <%=i%>
                </th>
                <th align="right">

                    <%=currencyFormat.format(loan.getBegBal(i))%>
                </th>
                <th align="right">
                    <%=currencyFormat.format(loan.getIntCharged(i))%>
                </th>
                <th align="right">
                    <%=currencyFormat.format(loan.getMonthlyPayment()-loan.getIntCharged(i))%>
                </th>
                <th align="right">
                    <%=currencyFormat.format(loan.getEndBal(i))%>
                </th>
            </tr>
            <%
                }
            %>
        </table>
        
            <%
                } catch (Exception e) {
            %>
            
            <p>
                Process Error on data validation
                <%=e.getMessage()%>. Use back arrow to retry.
            </p>
            
            <%
                }
            %>
    </body>
</html>
