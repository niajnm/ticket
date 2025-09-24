import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/model/profile_model.dart';
import 'package:ticket/app/presentation/profile/profile_provider.dart';
import 'package:ticket/app/presentation/profile/role_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      profileProvider.loadProfileFromJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);

    if (provider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (provider.error != null) {
      return Scaffold(body: Center(child: Text(provider.error!)));
    }

    if (provider.profile == null) {
      return const Scaffold(body: Center(child: Text("No profile found")));
    }

    final profile = provider.profile!;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My profile',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileHeader(profile),
                  _buildBasicInfo(profile),
                  _buildAssignedRoles(profile.roles),
                ],
              ),
            ),
          ),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(Profile profile) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFE3F2FD),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(profile.avatar),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.designation,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.edit, size: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfo(Profile profile) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // left align
        mainAxisSize: MainAxisSize.min, // only take needed vertical space
        children: [
          // Header
          const Text(
            'Name & Basic Info',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),

          // Info fields
          _InfoField(label: 'First name', value: profile.firstName),
          const SizedBox(height: 20),
          _InfoField(label: 'Last name', value: profile.lastName),
          const SizedBox(height: 20),
          _InfoField(label: 'Email', value: profile.email),
        ],
      ),
    );
  }

  Widget _buildAssignedRoles(List<Role> roles) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assigned roles (${roles.length})',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 170,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: roles.length,
              separatorBuilder: (_, __) => const SizedBox(width: 15),
              itemBuilder: (_, index) {
                final role = roles[index];
                return SizedBox(
                  width: 260,
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: RoleCard(
                        title: role.title,
                        subtitle: role.subtitle,
                        avatarUrl: role.avatarUrl,
                        name: role.name,
                        isPartial: role.isPartial,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFFFCDD2),
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Color(0xFFE91E63), size: 18),
            SizedBox(width: 8),
            Text(
              'Log out',
              style: TextStyle(
                color: Color(0xFFE91E63),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  final String label;
  final String value;

  const _InfoField({Key? key, required this.label, required this.value})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
