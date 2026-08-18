import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        elevation: 0,
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildAdminBottomNav(),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardTab();
      case 1:
        return _buildTournamentsTab();
      case 2:
        return _buildWithdrawalsTab();
      case 3:
        return _buildDisputesTab();
      default:
        return _buildDashboardTab();
    }
  }

  /// Dashboard Tab - Overview Statistics
  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key Metrics Grid
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildMetricCard(
                title: 'Total Revenue',
                value: '₹2,50,000',
                icon: '💰',
                color: const Color(0xFF10B981),
              ),
              _buildMetricCard(
                title: 'Active Tournaments',
                value: '12',
                icon: '🎮',
                color: const Color(0xFF6366F1),
              ),
              _buildMetricCard(
                title: 'Total Players',
                value: '450',
                icon: '👥',
                color: const Color(0xFF3B82F6),
              ),
              _buildMetricCard(
                title: 'Pending Withdrawals',
                value: '8',
                icon: '⏳',
                color: const Color(0xFFF59E0B),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Recent Activity',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildActivityItem(
            'New Tournament Created',
            'BGMI Squad - ₹50,000 Prize Pool',
            '2 hours ago',
          ),
          _buildActivityItem(
            'Withdrawal Approved',
            'User #42134 - ₹5,000 via UPI',
            '1 hour ago',
          ),
          _buildActivityItem(
            'Dispute Resolved',
            'Tournament #T-2025-001 Prize Distributed',
            '30 minutes ago',
          ),
        ],
      ),
    );
  }

  /// Tournaments Management Tab
  Widget _buildTournamentsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate to create tournament
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text(
              '+ Create New Tournament',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildTournamentItem(
            'BGMI Squad Championship',
            status: 'live',
            entryFee: 500,
            players: '45/50',
            prizePool: 50000,
          ),
          _buildTournamentItem(
            'Free Fire Solo Battle',
            status: 'upcoming',
            entryFee: 250,
            players: '30/40',
            prizePool: 25000,
          ),
          _buildTournamentItem(
            'Ludo Classic Turbo',
            status: 'completed',
            entryFee: 100,
            players: '50/50',
            prizePool: 10000,
          ),
        ],
      ),
    );
  }

  /// Withdrawals Management Tab
  Widget _buildWithdrawalsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildWithdrawalRequest(
            userName: 'Player #42134',
            amount: 5000,
            method: 'UPI',
            upiId: 'player@upi',
            status: 'pending',
            onApprove: () {},
            onReject: () {},
          ),
          const SizedBox(height: 12),
          _buildWithdrawalRequest(
            userName: 'Player #42135',
            amount: 10000,
            method: 'Bank Transfer',
            upiId: 'SBIN0001234',
            status: 'pending',
            onApprove: () {},
            onReject: () {},
          ),
          const SizedBox(height: 12),
          _buildWithdrawalRequest(
            userName: 'Player #42136',
            amount: 2500,
            method: 'UPI',
            upiId: 'player2@upi',
            status: 'approved',
            onApprove: () {},
            onReject: () {},
          ),
        ],
      ),
    );
  }

  /// Disputes Resolution Tab
  Widget _buildDisputesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildDisputeCard(
            userName: 'Player #42134',
            tournamentName: 'BGMI Squad Championship',
            disputeType: 'Result Verification',
            description: 'Screenshot shows victory but rank not updated',
            status: 'open',
            onReview: () {},
          ),
          const SizedBox(height: 12),
          _buildDisputeCard(
            userName: 'Player #42135',
            tournamentName: 'Free Fire Battle',
            disputeType: 'Prize Not Received',
            description: 'Won prize but not received in wallet',
            status: 'investigating',
            onReview: () {},
          ),
        ],
      ),
    );
  }

  /// Metric Card Widget
  Widget _buildMetricCard({
    required String title,
    required String value,
    required String icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  /// Activity Item
  Widget _buildActivityItem(
    String title,
    String subtitle,
    String time,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: Color(0xFF6366F1),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  /// Tournament Item for Management
  Widget _buildTournamentItem({
    required String title,
    required String status,
    required double entryFee,
    required String players,
    required double prizePool,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: status == 'live'
                      ? const Color(0xFFDCFCE7)
                      : status == 'upcoming'
                          ? const Color(0xFFFEF3C7)
                          : const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: status == 'live'
                        ? const Color(0xFF065F46)
                        : status == 'upcoming'
                            ? const Color(0xFF78350F)
                            : const Color(0xFF374151),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTournamentDetail('Entry Fee', '₹${entryFee.toStringAsFixed(0)}'),
              _buildTournamentDetail('Players', players),
              _buildTournamentDetail('Prize', '₹${(prizePool / 1000).toStringAsFixed(0)}K'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: const Text('Edit', style: TextStyle(fontSize: 12)),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: const Text('Delete', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Tournament Detail
  Widget _buildTournamentDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xFF6B7280),
            fontSize: 10,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  /// Withdrawal Request Card
  Widget _buildWithdrawalRequest({
    required String userName,
    required double amount,
    required String method,
    required String upiId,
    required String status,
    required VoidCallback onApprove,
    required VoidCallback onReject,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: status == 'pending'
              ? const Color(0xFFFCD34D)
              : const Color(0xFFD1D5DB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${amount.toStringAsFixed(0)} via $method',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: status == 'pending'
                      ? const Color(0xFFFEF3C7)
                      : const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: status == 'pending'
                        ? const Color(0xFF78350F)
                        : const Color(0xFF065F46),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            upiId,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF6B7280),
              fontSize: 10,
            ),
          ),
          if (status == 'pending') ...[const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onApprove,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                  ),
                  child: const Text(
                    'Approve',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: onReject,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444),
                  ),
                  child: const Text(
                    'Reject',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            )]
        ],
      ),
    );
  }

  /// Dispute Card for Admin
  Widget _buildDisputeCard({
    required String userName,
    required String tournamentName,
    required String disputeType,
    required String description,
    required String status,
    required VoidCallback onReview,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: status == 'open'
              ? const Color(0xFFFCA5A5)
              : status == 'investigating'
                  ? const Color(0xFFFCD34D)
                  : const Color(0xFFD1D5DB),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tournamentName,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: status == 'open'
                      ? const Color(0xFFFEE2E2)
                      : status == 'investigating'
                          ? const Color(0xFFFEF3C7)
                          : const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: status == 'open'
                        ? const Color(0xFF7F1D1D)
                        : status == 'investigating'
                            ? const Color(0xFF78350F)
                            : const Color(0xFF065F46),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  disputeType,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
              ),
              child: const Text(
                'Review & Resolve',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Admin Bottom Navigation Bar
  Widget _buildAdminBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() => _selectedIndex = index);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF6366F1),
      unselectedItemColor: const Color(0xFF9CA3AF),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tournament),
          label: 'Tournaments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment),
          label: 'Withdrawals',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.warning),
          label: 'Disputes',
        ),
      ],
    );
  }
}
