package Pithub::Users::Followers;

# ABSTRACT: Github v3 User Followers API

use Moose;
use Carp qw(croak);
use namespace::autoclean;
extends 'Pithub::Base';

=method follow

=over

=item *

Follow a user

    PUT /user/following/:user

Examples:

    $p = Pithub->new( token => 'b3c62c6' );
    $result = $p->users->followers->follow( user => 'plu' );

    $f = Pithub::Users::Followers->new( token => 'b3c62c6' );
    $result = $f->follow( user => 'plu' );

=back

=cut

sub follow {
    my ( $self, %args ) = @_;
    croak 'Missing key in parameters: user' unless $args{user};
    return $self->request( PUT => sprintf( '/user/following/%s', $args{user} ) );
}

=method is_following

=over

=item *

Check if the authenticated user is following another given user

    GET /user/following/:user

Examples:

    $p = Pithub->new( token => 'b3c62c6' );
    $result = $p->users->followers->is_following( user => 'rafl' );

    $f = Pithub::Users::Followers->new( token => 'b3c62c6' );
    $result = $f->is_following( user => 'rafl' );

    if ( $result->is_success ) {
        print "plu is following rafl\n";
    }
    elsif ( $result->code == 404 ) {
        print "plu is not following rafl\n";
    }

=back

=cut

sub is_following {
    my ( $self, %args ) = @_;
    croak 'Missing key in parameters: user' unless $args{user};
    return $self->request( GET => sprintf( '/user/following/%s', $args{user} ) );
}

=method list

=over

=item *

List a user's followers:

    GET /users/:user/followers

=item *

List the authenticated user's followers:

    GET /user/followers

Examples:

    $p = Pithub->new;
    $result = $p->users->followers->list( user => 'plu' );

    $f = Pithub::Users::Followers->new;
    $result = $f->list( user => 'plu' );

    $p = Pithub->new( token => 'b3c62c6' );
    $result = $p->users->followers->list;

    $f = Pithub::Users::Followers->new( token => 'b3c62c6' );
    $result = $f->list;

=back

=cut

sub list {
    my ( $self, %args ) = @_;
    if ( $args{user} ) {
        return $self->request( GET => sprintf( '/users/%s/followers', $args{user} ) );
    }
    return $self->request( GET => '/user/followers' );
}

=method list_following

=over

=item *

List who a user is following:

    GET /users/:user/following

=item *

List who the authenicated user is following:

    GET /user/following

Examples:

    $p = Pithub->new;
    $result = $p->users->followers->list_following( user => 'plu' );

    $f = Pithub::Users::Followers->new;
    $result = $f->list_following( user => 'plu' );

    $p = Pithub->new( token => 'b3c62c6' );
    $result = $p->users->followers->list_following;

    $f = Pithub::Users::Followers->new( token => 'b3c62c6' );
    $result = $f->list_following;

=back

=cut

sub list_following {
    my ( $self, %args ) = @_;
    if ( $args{user} ) {
        return $self->request( GET => sprintf( '/users/%s/following', $args{user} ) );
    }
    return $self->request( GET => '/user/following' );
}

=method unfollow

=over

=item *

Unfollow a user

    DELETE /user/following/:user

Examples:

    $p = Pithub->new;
    $result = $p->users->followers->unfollow( user => 'plu' );

    $f = Pithub::Users::Followers->new;
    $result = $f->unfollow( user => 'plu' );

=back

=cut

sub unfollow {
    my ( $self, %args ) = @_;
    croak 'Missing key in parameters: user' unless $args{user};
    return $self->request( DELETE => sprintf( '/user/following/%s', $args{user} ) );
}

__PACKAGE__->meta->make_immutable;

1;
