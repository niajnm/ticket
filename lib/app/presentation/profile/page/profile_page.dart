import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/model/profile_model.dart';
import 'package:ticket/app/presentation/profile/view_model/profile_viewmodel.dart';
import 'package:ticket/app/presentation/profile/widgets/logout_button.dart';
import 'package:ticket/app/presentation/profile/widgets/role_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileProvider = Provider.of<ProfileViewModel>(
        context,
        listen: false,
      );
      profileProvider.loadProfileFromJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileViewModel>(context);

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
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'My profile',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
      color: const Color.fromARGB(111, 227, 242, 253),
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            child: const Icon(Icons.edit, size: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfo(Profile profile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          const Text(
            'Name & Basic Info',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assigned roles (${roles.length})',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                    elevation: 0,
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

  Widget _buildLogoutButton() => LogoutButton(
    onTap: () {
      print('User logged out');
    },
  );
}

class _InfoField extends StatelessWidget {
  final String label;
  final String value;

  const _InfoField({required this.label, required this.value});

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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
