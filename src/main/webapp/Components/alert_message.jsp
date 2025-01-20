<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 8:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="lk.ecommerce.ecommerce1.entities.Message" %>
<%
    Message messg = (Message) session.getAttribute("message");
    if (messg != null) {
%>
<div class="alert <%=messg.getCssClass()%>" role="alert" id="alert">
    <%=messg.getMessage()%>
</div>
<%
    session.removeAttribute("message");
%>
<script type="text/javascript">
    setTimeout(function() {
        $('#alert').alert('close');
    }, 3000);
</script>
<%
    }

