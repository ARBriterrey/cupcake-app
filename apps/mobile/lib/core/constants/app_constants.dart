/// Application-wide constants
class AppConstants {
  // App Info
  static const String appName = 'Cupcake';
  static const String appVersion = '0.1.0';

  // Database Tables
  static const String profilesTable = 'profiles';
  static const String pairsTable = 'pairs';
  static const String pairInvitationsTable = 'pair_invitations';
  static const String pairEntitlementsTable = 'pair_entitlements';

  // Invitation
  static const int invitationExpiryDays = 7;

  // Pagination
  static const int defaultPageSize = 20;
}
