<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<!-- BookShop Pro - Dashboard Page -->
<!-- Save as: src/main/webapp/pages/dashboard.jsp -->

<!DOCTYPE html>
<html lang="en">
<head>
    <title>BookShop Pro - Dashboard</title>
    <%@ include file="../components/header.jsp" %>
</head>
<body class="min-h-screen bg-gradient-to-br from-indigo-900 via-purple-900 to-pink-800 font-inter">
    
    <!-- Mobile Sidebar Overlay -->
    <div id="sidebarOverlay" class="fixed inset-0 bg-black/50 z-40 lg:hidden hidden"></div>
    
    <!-- Sidebar -->
    <aside id="sidebar" class="dashboard-sidebar fixed left-0 top-0 z-50 w-64 lg:translate-x-0 transform -translate-x-full lg:relative lg:w-64">
        <!-- Logo -->
        <div class="flex items-center mb-8">
            <div class="w-10 h-10 glass rounded-lg flex items-center justify-center mr-3">
                <i class="fas fa-book-reader text-white text-lg"></i>
            </div>
            <div>
                <h2 class="text-white font-bold text-lg">BookShop Pro</h2>
                <p class="text-white/60 text-xs">Billing System</p>
            </div>
        </div>
        
        <!-- Navigation Menu -->
        <nav class="space-y-2">
            <a href="dashboard.jsp" class="nav-item active">
                <i class="fas fa-home"></i>
                Dashboard
            </a>
            <a href="inventory.jsp" class="nav-item">
                <i class="fas fa-book"></i>
                Inventory
            </a>
            <a href="billing.jsp" class="nav-item">
                <i class="fas fa-receipt"></i>
                Billing
            </a>
            <a href="customers.jsp" class="nav-item">
                <i class="fas fa-users"></i>
                Customers
            </a>
            <a href="reports.jsp" class="nav-item">
                <i class="fas fa-chart-bar"></i>
                Reports
            </a>
            <a href="settings.jsp" class="nav-item">
                <i class="fas fa-cog"></i>
                Settings
            </a>
            <a href="logout" class="nav-item text-red-300 hover:text-red-200">
                <i class="fas fa-sign-out-alt"></i>
                Logout
            </a>
        </nav>
    </aside>
    
    <!-- Main Content -->
    <div class="lg:ml-64">
        <!-- Top Header -->
        <header class="glass-card m-4 mb-0 p-4 flex items-center justify-between">
            <!-- Mobile Menu Button -->
            <button id="mobileMenuBtn" class="lg:hidden text-white p-2 hover-glow rounded-lg">
                <i class="fas fa-bars text-xl"></i>
            </button>
            
            <!-- Page Title -->
            <div class="flex items-center">
                <h1 class="text-white text-2xl font-bold">Dashboard</h1>
                <span class="ml-3 px-3 py-1 bg-green-500/20 text-green-300 rounded-full text-xs">
                    Online
                </span>
            </div>
            
            <!-- User Menu -->
            <div class="flex items-center space-x-4">
                <!-- Notifications -->
                <button class="relative text-white/80 hover:text-white p-2 hover-glow rounded-lg">
                    <i class="fas fa-bell text-xl"></i>
                    <span class="absolute -top-1 -right-1 w-3 h-3 bg-red-500 rounded-full"></span>
                </button>
                
                <!-- User Profile -->
                <div class="flex items-center space-x-2">
                    <div class="w-8 h-8 bg-gradient-to-r from-pink-400 to-purple-400 rounded-full flex items-center justify-center">
                        <span class="text-white text-sm font-semibold">
                            <%= session.getAttribute("username") != null ? 
                                ((String)session.getAttribute("username")).substring(0,1).toUpperCase() : "U" %>
                        </span>
                    </div>
                    <span class="text-white/90 text-sm hidden sm:block">
                        <%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %>
                    </span>
                </div>
            </div>
        </header>
        
        <!-- Dashboard Content -->
        <main class="dashboard-content">
            <!-- Stats Cards -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div class="stat-card hover-lift animate-fade-in">
                    <div class="stat-number text-gradient">1,234</div>
                    <div class="stat-label">Total Books</div>
                    <div class="mt-2 text-green-400 text-sm">
                        <i class="fas fa-arrow-up mr-1"></i>
                        +12% from last month
                    </div>
                </div>
                
                <div class="stat-card hover-lift animate-fade-in" style="animation-delay: 0.1s;">
                    <div class="stat-number text-gradient">₹89,432</div>
                    <div class="stat-label">Monthly Sales</div>
                    <div class="mt-2 text-green-400 text-sm">
                        <i class="fas fa-arrow-up mr-1"></i>
                        +8% from last month
                    </div>
                </div>
                
                <div class="stat-card hover-lift animate-fade-in" style="animation-delay: 0.2s;">
                    <div class="stat-number text-gradient">567</div>
                    <div class="stat-label">Orders</div>
                    <div class="mt-2 text-yellow-400 text-sm">
                        <i class="fas fa-minus mr-1"></i>
                        Same as last month
                    </div>
                </div>
                
                <div class="stat-card hover-lift animate-fade-in" style="animation-delay: 0.3s;">
                    <div class="stat-number text-gradient">98%</div>
                    <div class="stat-label">Customer Satisfaction</div>
                    <div class="mt-2 text-green-400 text-sm">
                        <i class="fas fa-arrow-up mr-1"></i>
                        +2% from last month
                    </div>
                </div>
            </div>
            
            <!-- Recent Orders & Quick Actions -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Recent Orders -->
                <div class="lg:col-span-2">
                    <div class="modern-card animate-slide-left">
                        <div class="flex items-center justify-between mb-6">
                            <h3 class="text-white text-xl font-semibold">Recent Orders</h3>
                            <a href="orders.jsp" class="text-pink-300 hover:text-pink-200 text-sm">
                                View All <i class="fas fa-arrow-right ml-1"></i>
                            </a>
                        </div>
                        
                        <div class="modern-table">
                            <table class="w-full">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="hover:bg-white/5">
                                        <td>#ORD-001</td>
                                        <td>John Doe</td>
                                        <td>₹1,250</td>
                                        <td><span class="px-2 py-1 bg-green-500/20 text-green-300 rounded-full text-xs">Completed</span></td>
                                    </tr>
                                    <tr class="hover:bg-white/5">
                                        <td>#ORD-002</td>
                                        <td>Jane Smith</td>
                                        <td>₹890</td>
                                        <td><span class="px-2 py-1 bg-yellow-500/20 text-yellow-300 rounded-full text-xs">Pending</span></td>
                                    </tr>
                                    <tr class="hover:bg-white/5">
                                        <td>#ORD-003</td>
                                        <td>Mike Johnson</td>
                                        <td>₹2,100</td>
                                        <td><span class="px-2 py-1 bg-blue-500/20 text-blue-300 rounded-full text-xs">Processing</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="space-y-6">
                    <div class="modern-card animate-slide-right">
                        <h3 class="text-white text-xl font-semibold mb-6">Quick Actions</h3>
                        
                        <div class="space-y-3">
                            <button onclick="window.location.href='billing.jsp'" class="w-full btn-primary text-left">
                                <i class="fas fa-plus mr-3"></i>
                                New Sale
                            </button>
                            
                            <button onclick="window.location.href='inventory.jsp'" class="w-full btn-secondary text-left">
                                <i class="fas fa-book mr-3"></i>
                                Add Book
                            </button>
                            
                            <button onclick="window.location.href='customers.jsp'" class="w-full bg-white/10 border border-white/20 text-white py-3 px-4 rounded-xl hover:bg-white/20 transition-all text-left">
                                <i class="fas fa-user-plus mr-3"></i>
                                New Customer
                            </button>
                            
                            <button onclick="generateReport()" class="w-full bg-white/10 border border-white/20 text-white py-3 px-4 rounded-xl hover:bg-white/20 transition-all text-left">
                                <i class="fas fa-file-download mr-3"></i>
                                Generate Report
                            </button>
                        </div>
                    </div>
                    
                    <!-- Low Stock Alert -->
                    <div class="modern-card bg-orange-500/10 border-orange-500/20 animate-slide-right" style="animation-delay: 0.2s;">
                        <div class="flex items-center mb-4">
                            <i class="fas fa-exclamation-triangle text-orange-300 text-xl mr-3"></i>
                            <h4 class="text-orange-300 font-semibold">Low Stock Alert</h4>
                        </div>
                        <p class="text-orange-200 text-sm mb-4">5 books are running low on stock</p>
                        <button onclick="window.location.href='inventory.jsp?filter=low-stock'" class="text-orange-300 hover:text-orange-200 text-sm underline">
                            View Details
                        </button>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Custom JavaScript -->
    <script>
        // Generate report function
        function generateReport() {
            const btn = event.target;
            BookShopPro.LoadingManager.show(btn, 'Generating...');
            
            // Simulate report generation
            setTimeout(() => {
                BookShopPro.LoadingManager.hide(btn);
                BookShopPro.AlertManager.show('Report generated successfully!', 'success');
            }, 2000);
        }
        
        // Initialize dashboard
        document.addEventListener('DOMContentLoaded', function() {
            // Add animation delays to cards
            const cards = document.querySelectorAll('.stat-card');
            cards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });
            
            // Auto-refresh data every 5 minutes
            setInterval(refreshDashboardData, 300000);
        });
        
        // Refresh dashboard data
        async function refreshDashboardData() {
            try {
                const data = await BookShopPro.AjaxManager.get('DashboardDataServlet');
                updateStatsCards(data);
            } catch (error) {
                console.error('Failed to refresh dashboard data:', error);
            }
        }
        
        // Update stats cards with new data
        function updateStatsCards(data) {
            if (data.totalBooks) {
                document.querySelector('.stat-card:nth-child(1) .stat-number').textContent = data.totalBooks;
            }
            if (data.monthlySales) {
                document.querySelector('.stat-card:nth-child(2) .stat-number').textContent = `₹${data.monthlySales}`;
            }
            if (data.orders) {
                document.querySelector('.stat-card:nth-child(3) .stat-number').textContent = data.orders;
            }
            if (data.satisfaction) {
                document.querySelector('.stat-card:nth-child(4) .stat-number').textContent = `${data.satisfaction}%`;
            }
        }
    </script>
</body>
</html>