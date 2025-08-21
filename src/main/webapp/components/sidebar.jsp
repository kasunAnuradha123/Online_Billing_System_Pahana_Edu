<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="user" value="${sessionScope.loggedUser}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pahana Edu - Sidebar</title>
    <!-- Tailwind + FontAwesome assumed included in layout -->
</head>
<body>

    <aside class="w-72 text-white flex flex-col">
        <!-- Logo / Header -->
        <div class="p-6 border-b border-white/20 animate-fade-in">
            <div class="flex items-center space-x-4">
                <div class="inline-flex items-center justify-center w-12 h-12 bg-white/10 backdrop-blur-md rounded-full border border-white/20">
                    <i class="fas fa-book-reader text-xl text-white"></i>
                </div>
                <div>
                    <h1 class="text-xl font-bold text-white">Pahana Edu</h1>
                    <p class="text-white/70 text-sm">BookShop</p>
                </div>
            </div>
        </div>

        <!-- Navigation -->
        <nav class="flex-1 p-4 space-y-2">
            <!-- Billing -->
            <a href="<%=request.getContextPath()%>/BillingServlet"
               class="group flex items-center p-4 rounded-xl hover:bg-white/10 transition-all duration-300 transform hover:scale-[1.02] hover:shadow-lg">
                <div class="flex items-center justify-center w-10 h-10 bg-gradient-to-r from-yellow-500 to-orange-500 rounded-lg mr-4 group-hover:shadow-lg group-hover:shadow-yellow-500/25 transition-all duration-300">
                    <i class="fas fa-file-invoice-dollar text-white text-sm"></i>
                </div>
                <div class="flex-1">
                    <span class="text-white font-medium">Billing</span>
                    <p class="text-white/60 text-xs">Invoice & Payments</p>
                </div>
                <i class="fas fa-chevron-right text-white/40 group-hover:text-white/80 transition-all duration-300"></i>
            </a>

            <!-- Customers -->
            <a href="<%=request.getContextPath()%>/CustomerServlet"
               class="group flex items-center p-4 rounded-xl hover:bg-white/10 transition-all duration-300 transform hover:scale-[1.02] hover:shadow-lg">
                <div class="flex items-center justify-center w-10 h-10 bg-gradient-to-r from-green-500 to-emerald-500 rounded-lg mr-4 group-hover:shadow-lg group-hover:shadow-green-500/25 transition-all duration-300">
                    <i class="fas fa-users text-white text-sm"></i>
                </div>
                <div class="flex-1">
                    <span class="text-white font-medium">Customers</span>
                    <p class="text-white/60 text-xs">Manage Customer Data</p>
                </div>
                <i class="fas fa-chevron-right text-white/40 group-hover:text-white/80 transition-all duration-300"></i>
            </a>
 <c:if test="${user.role == 'admin'}">
            <!-- Inventory -->
            <a href="<%=request.getContextPath()%>/ItemServlet"
               class="group flex items-center p-4 rounded-xl hover:bg-white/10 transition-all duration-300 transform hover:scale-[1.02] hover:shadow-lg">
                <div class="flex items-center justify-center w-10 h-10 bg-gradient-to-r from-purple-500 to-pink-500 rounded-lg mr-4 group-hover:shadow-lg group-hover:shadow-purple-500/25 transition-all duration-300">
                    <i class="fas fa-box text-white text-sm"></i>
                </div>
                <div class="flex-1">
                    <span class="text-white font-medium">Inventory</span>
                    <p class="text-white/60 text-xs">Books & Items</p>
                </div>
                <i class="fas fa-chevron-right text-white/40 group-hover:text-white/80 transition-all duration-300"></i>
            </a>

            <!-- Sales -->
            <a href="<%=request.getContextPath()%>/SalesServlet"
               class="group flex items-center p-4 rounded-xl hover:bg-white/10 transition-all duration-300 transform hover:scale-[1.02] hover:shadow-lg">
                <div class="flex items-center justify-center w-10 h-10 bg-gradient-to-r from-red-500 to-pink-500 rounded-lg mr-4 group-hover:shadow-lg group-hover:shadow-red-500/25 transition-all duration-300">
                    <i class="fas fa-chart-line text-white text-sm"></i>
                </div>
                <div class="flex-1">
                    <span class="text-white font-medium">Sales & Reports</span>
                    <p class="text-white/60 text-xs">Sales & Statistics</p>
                </div>
                <i class="fas fa-chevron-right text-white/40 group-hover:text-white/80 transition-all duration-300"></i>
            </a>

            <!-- Users -->
            <a href="<%=request.getContextPath()%>/UserServlet"
               class="group flex items-center p-4 rounded-xl hover:bg-white/10 transition-all duration-300 transform hover:scale-[1.02] hover:shadow-lg">
                <div class="flex items-center justify-center w-10 h-10 bg-gradient-to-r from-gray-500 to-slate-500 rounded-lg mr-4 group-hover:shadow-lg group-hover:shadow-gray-500/25 transition-all duration-300">
                    <i class="fas fa-cog text-white text-sm"></i>
                </div>
                <div class="flex-1">
                    <span class="text-white font-medium">System Users</span>
                    <p class="text-white/60 text-xs">System User Management</p>
                </div>
                <i class="fas fa-chevron-right text-white/40 group-hover:text-white/80 transition-all duration-300"></i>
            </a>
 </c:if>
            <!-- Help -->
            <a href="<%=request.getContextPath()%>/View/help/index.jsp"
               class="group flex items-center p-4 rounded-xl hover:bg-white/10 transition-all duration-300 transform hover:scale-[1.02] hover:shadow-lg">
                <div class="flex items-center justify-center w-10 h-10 bg-gradient-to-r from-blue-500 to-cyan-500 rounded-lg mr-4 group-hover:shadow-lg group-hover:shadow-blue-500/25 transition-all duration-300">
                    <i class="fas fa-chart-pie text-white text-sm"></i>
                </div>
                <div class="flex-1">
                    <span class="text-white font-medium">Help</span>
                    <p class="text-white/60 text-xs">Q&A and More information</p>
                </div>
                <i class="fas fa-chevron-right text-white/40 group-hover:text-white/80 transition-all duration-300"></i>
            </a>
        </nav>

        <!-- Logout + Footer -->
        <div class="p-4 border-t border-white/20 animate-fade-in" style="animation-delay: 0.8s;">
            <form action="<%=request.getContextPath()%>/LogoutServlet" method="get">
                <button type="submit"
                    class="w-full bg-gradient-to-r from-red-500 to-pink-600 hover:from-red-600 hover:to-pink-700 text-white font-medium py-3 px-4 rounded-xl transition-all duration-300 transform hover:scale-[1.02] hover:shadow-lg hover:shadow-red-500/25 focus:outline-none focus:ring-2 focus:ring-red-400 focus:ring-offset-2 focus:ring-offset-transparent">
                    <i class="fas fa-sign-out-alt mr-2"></i>
                    <span>Logout</span>
                </button>
            </form>

            <div class="mt-4 text-center">
                <p class="text-white/40 text-xs">© 2025 Pahana Edu BookShop</p>
                <p class="text-white/30 text-xs">v2.1.0</p>
            </div>
        </div>
    </aside>

</body>
</html>
