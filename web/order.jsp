<%@include file="template/headerAdmin.jsp" %>
<%@page import="java.time.LocalDateTime" %>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    LocalDateTime now = LocalDateTime.now();
    String date = dtf.format(now);
%>

<div id="content-right">
    <div class="path-admin">ORDERS LIST</b></div>
    <div class="content-main">
        <div id="content-main-dashboard">
            <div id="order-title">
                <b>Filter by Order date:</b>
                <form action="OrderManager" method="post">
                    From: <input type="date" name="txtStartOrderDate" value="${txtStartOrderDate}"  max="<%=date%>"/>
                    To: <input type="date" name="txtEndOrderDate" value="${txtEndOrderDate}>"/>
                    <input type="submit" value="Filter">
                </form>
            </div>
            <div id="order-table">
                <table id="orders">
                    <tr>
                        <th>OrderID</th>
                        <th>OrderDate</th>
                        <th>RequiredDate</th>
                        <th>ShippedDate</th>
                        <th>Employee</th>
                        <th>Customer</th>
                        <th>Freight($)</th>
                        <th>Status</th>
                    </tr>
                    <c:forEach items="${listAll}" var="item">
                        <tr>
                            <td><a href="order-detail.html?id=5">#${item.getOrderID()}</a></td>
                            <td>${item.getOrderDate()}</td>
                            <td>${item.getRequiredDate()}</td>
                            <td>${item.getShippedDate()}</td>
                            <td>${item.getEmployeeID()}</td>
                            <td>${item.getShipName()}</td>
                            <td>${item.getFreight()}</td>
                            <c:choose>
                                <c:when test="${item.getShippedDate() != null}">
                                    <td style="color: green;">
                                        Completed
                                    </td>
                                </c:when>
                                <c:when test="${item.getRequiredDate() == null}">
                                    <td style="color: red;">Order canceled</td>
                                </c:when>
                                <c:when test="${item.getShippedDate() == null}">
                                    <td style="color: blue;">
                                        Pending | <a href="CancelByAdmin?oid=${item.getOrderID()}">Cancel</a>                                    
                                    </td>
                                </c:when>
                            </c:choose>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <c:if test="${numberOfPage > 1}">
                <div id="paging">
                    <div class="pagination">
                        <c:forEach var = "i" begin = "1" end = "${numberOfPage}">
                            <c:choose>
                                <c:when test="${i==page}">
                                    <button class="active">
                                        <div class="pageNumber" ><a  href="OrderManager?page=${i}">${i}</a></div>
                                    </button>
                                </c:when>    
                                <c:otherwise>
                                    <button>
                                        <div class="pageNumber" ><a  href="OrderManager?page=${i}">${i}</a></div>
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>
</div>
<%@include file="template/footer.jsp" %>
<style>
        .active{
            background: green;
        }

    </style>
