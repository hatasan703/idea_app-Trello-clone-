| Prefix Verb | URI Pattern | Controller#Action |
|-------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------|
| root GET | / | top#index |
| companies GET | /companies(.:format) | companies#index |
| POST | /companies(.:format) | companies#create |
| new_company GET | /companies/new(.:format) | companies#new |
| public_company_ideas GET | /companies/:company_id/ideas/public(.:format) | ideas#public |
| company_ideas GET | /companies/:company_id/ideas(.:format) | ideas#index |
| POST | /companies/:company_id/ideas(.:format) | ideas#create |
| company_idea PATCH | /companies/:company_id/ideas/:id(.:format) | ideas#update |
| PUT | /companies/:company_id/ideas/:id(.:format) | ideas#update |
| GET | /companies(.:format) | companies#index |
| POST | /companies(.:format) | companies#create |
| GET | /companies/new(.:format) | companies#new |
| edit_company GET | /companies/:id/edit(.:format) | companies#edit |
| company GET | /companies/:id(.:format) | companies#show |
| PATCH | /companies/:id(.:format) | companies#update |
| PUT | /companies/:id(.:format) | companies#update |
| DELETE /companies/:id(.:format) | companies#destroy |  |
| inviting GET | /accept/:token(.:format) | companies/formal_registrations#new {:param=>:token} |
| groups GET | /groups(.:format) | groups#index |
| POST | /groups(.:format) | groups#create |
| new_group GET | /groups/new(.:format) | groups#new |
| edit_group GET | /groups/:id/edit(.:format) | groups#edit |
| group GET | /groups/:id(.:format) | groups#show |
| PATCH | /groups/:id(.:format) | groups#update |
| PUT | /groups/:id(.:format) | groups#update |
| DELETE /groups/:id(.:format) | groups#destroy |  |
| joingroups GET | /joingroups(.:format) | joingroups#index |
| POST | /joingroups(.:format) | joingroups#create |
| new_joingroup GET | /joingroups/new(.:format) | joingroups#new |
| edit_joingroup GET | /joingroups/:id/edit(.:format) | joingroups#edit |
| joingroup GET | /joingroups/:id(.:format) | joingroups#show |
| PATCH | /joingroups/:id(.:format) | joingroups#update |
| PUT | /joingroups/:id(.:format) | joingroups#update |
| DELETE /joingroups/:id(.:format) | joingroups#destroy |  |
| edit_management_authorization GET | /management_authorizations/:id/edit(.:format) | management_authorizations#edit |
| management_authorization PATCH | /management_authorizations/:id(.:format) | management_authorizations#update |
| PUT | /management_authorizations/:id(.:format) | management_authorizations#update |
| DELETE /management_authorizations/:id(.:format) | management_authorizations#destroy |  |
| new_user_session GET | /users/sign_in(.:format) | devise/sessions#new |
| user_session POST | /users/sign_in(.:format) | devise/sessions#create |
| destroy_user_session DELETE /users/sign_out(.:format) | devise/sessions#destroy |  |
| new_user_password GET | /users/password/new(.:format) | devise/passwords#new |
| edit_user_password GET | /users/password/edit(.:format) | devise/passwords#edit |
| user_password PATCH | /users/password(.:format) | devise/passwords#update |
| PUT | /users/password(.:format) | devise/passwords#update |
| POST | /users/password(.:format) | devise/passwords#create |
| cancel_user_registration GET | /users/cancel(.:format) | devise_invitable/registrations#cancel |
| new_user_registration GET | /users/sign_up(.:format) | devise_invitable/registrations#new |
| edit_user_registration GET | /users/edit(.:format) | devise_invitable/registrations#edit |
| user_registration PATCH | /users(.:format) | devise_invitable/registrations#update |
| PUT | /users(.:format) | devise_invitable/registrations#update |
| DELETE /users(.:format) | devise_invitable/registrations#destroy |  |
| POST | /users(.:format) | devise_invitable/registrations#create |
| accept_user_invitation GET | /users/invitation/accept(.:format) | devise/invitations#edit |
| remove_user_invitation GET | /users/invitation/remove(.:format) | devise/invitations#destroy |
| new_user_invitation GET | /users/invitation/new(.:format) | devise/invitations#new |
| user_invitation PATCH | /users/invitation(.:format) | devise/invitations#update |
| PUT | /users/invitation(.:format) | devise/invitations#update |
| POST | /users/invitation(.:format) | devise/invitations#create |
| new_user_company_session GET | /users/companies/:company_id/sign_in(.:format) | devise/sessions#new |
| user_company_session POST | /users/companies/:company_id/sign_in(.:format) | devise/sessions#create |
| destroy_user_company_session DELETE /users/companies/:company_id/sign_out(.:format) | devise/sessions#destroy |  |
| new_user_company_password GET | /users/companies/:company_id/password/new(.:format) | devise/passwords#new |
| edit_user_company_password GET | /users/companies/:company_id/password/edit(.:format) | devise/passwords#edit |
| user_company_password PATCH | /users/companies/:company_id/password(.:format) | devise/passwords#update |
| PUT | /users/companies/:company_id/password(.:format) | devise/passwords#update |
| POST | /users/companies/:company_id/password(.:format) | devise/passwords#create |
| cancel_user_company_registration GET | /users/companies/:company_id/cancel(.:format) | devise_invitable/registrations#cancel |
| new_user_company_registration GET | /users/companies/:company_id/sign_up(.:format) | devise_invitable/registrations#new |
| edit_user_company_registration GET | /users/companies/:company_id/edit(.:format) | devise_invitable/registrations#edit |
| user_company_registration PATCH | /users/companies/:company_id(.:format) | devise_invitable/registrations#update |
| PUT | /users/companies/:company_id(.:format) | devise_invitable/registrations#update |
| DELETE /users/companies/:company_id(.:format) | devise_invitable/registrations#destroy |  |
| POST | /users/companies/:company_id(.:format) | devise_invitable/registrations#create |
| accept_user_company_invitation GET | /users/companies/:company_id/invitation/accept(.:format) | users/invitations#edit |
| remove_user_company_invitation GET | /users/companies/:company_id/invitation/remove(.:format) | users/invitations#destroy |
| new_user_company_invitation GET | /users/companies/:company_id/invitation/new(.:format) | users/invitations#new |
| user_company_invitation PATCH | /users/companies/:company_id/invitation(.:format) | users/invitations#update |
| PUT | /users/companies/:company_id/invitation(.:format) | users/invitations#update |
| POST | /users/companies/:company_id/invitation(.:format) | users/invitations#create |
| GET | /companies(.:format) | companies#index |
| POST | /companies(.:format) | companies#create |
| GET | /companies/new(.:format) | companies#new |
| GET | /companies/:id/edit(.:format) | companies#edit |
| GET | /companies/:id(.:format) | companies#show |
| PATCH | /companies/:id(.:format) | companies#update |
| PUT | /companies/:id(.:format) | companies#update |
| DELETE /companies/:id(.:format) | companies#destroy |  |
| authenticated_root GET | / | top#index |
| unauthenticated_root GET | / | devise/sessions#new |
| users GET | /users(.:format) | users#index |
| POST | /users(.:format) | users#create |
| new_user GET | /users/new(.:format) | users#new |
| edit_user GET | /users/:id/edit(.:format) | users#edit |
| user GET | /users/:id(.:format) | users#show |
| PATCH | /users/:id(.:format) | users#update |
| PUT | /users/:id(.:format) | users#update |
| DELETE /users/:id(.:format) | users#destroy |  |
| idea_plans GET | /ideas/:idea_id/plans(.:format) | plans#index |
| POST | /ideas/:idea_id/plans(.:format) | plans#create |
| new_idea_plan GET | /ideas/:idea_id/plans/new(.:format) | plans#new |
| edit_idea_plan GET | /ideas/:idea_id/plans/:id/edit(.:format) | plans#edit |
| idea_plan PATCH | /ideas/:idea_id/plans/:id(.:format) | plans#update |
| PUT | /ideas/:idea_id/plans/:id(.:format) | plans#update |
| public_ideas GET | /ideas/public(.:format) | ideas#public |
| news_idea GET | /ideas/:id/news(.:format) | ideas#news |
| move_idea PATCH | /ideas/:id/move(.:format) | ideas#move |
| ideas GET | /ideas(.:format) | ideas#index |
| POST | /ideas(.:format) | ideas#create |
| new_idea GET | /ideas/new(.:format) | ideas#new |
| edit_idea GET | /ideas/:id/edit(.:format) | ideas#edit |
| idea GET | /ideas/:id(.:format) | ideas#show |
| PATCH | /ideas/:id(.:format) | ideas#update |
| PUT | /ideas/:id(.:format) | ideas#update |
| DELETE /ideas/:id(.:format) | ideas#destroy |  |
| move_memo PATCH | /memos/:id/move(.:format) | memos#move |
| memos GET | /memos(.:format) | memos#index |
| POST | /memos(.:format) | memos#create |
| new_memo GET | /memos/new(.:format) | memos#new |
| edit_memo GET | /memos/:id/edit(.:format) | memos#edit |
| memo GET | /memos/:id(.:format) | memos#show |
| PATCH | /memos/:id(.:format) | memos#update |
| PUT | /memos/:id(.:format) | memos#update |
| DELETE /memos/:id(.:format) | memos#destroy |  |
| POST | /ideas/:id/comment(.:format) | comments#create |
| comments GET | /comments(.:format) | comments#index |
| POST | /comments(.:format) | comments#create |
| new_comment GET | /comments/new(.:format) | comments#new |
| edit_comment GET | /comments/:id/edit(.:format) | comments#edit |
| comment GET | /comments/:id(.:format) | comments#show |
| PATCH | /comments/:id(.:format) | comments#update |
| PUT | /comments/:id(.:format) | comments#update |
| DELETE /comments/:id(.:format) | comments#destroy |  |
| api_likes GET | /api/likes(.:format) | api/likes#index {:format=>/json/} |
| POST | /api/likes(.:format) | api/likes#create {:format=>/json/} |
| api_like DELETE /api/likes/:id(.:format) | api/likes#destroy {:format=>/json/} |  |
| profiles GET | /profiles(.:format) | profiles#index |
| POST | /profiles(.:format) | profiles#create |
| new_profile GET | /profiles/new(.:format) | profiles#new |
| edit_profile GET | /profiles/:id/edit(.:format) | profiles#edit |
| profile GET | /profiles/:id(.:format) | profiles#show |
| PATCH | /profiles/:id(.:format) | profiles#update |
| PUT | /profiles/:id(.:format) | profiles#update |
| DELETE /profiles/:id(.:format) | profiles#destroy |  |
| search_user_profiles GET | /search_user_profiles(.:format) | search_user_profiles#index |
| POST | /search_user_profiles(.:format) | search_user_profiles#create |
| new_search_user_profile GET | /search_user_profiles/new(.:format) | search_user_profiles#new |
| edit_search_user_profile GET | /search_user_profiles/:id/edit(.:format) | search_user_profiles#edit |
| search_user_profile GET | /search_user_profiles/:id(.:format) | search_user_profiles#show |
| PATCH | /search_user_profiles/:id(.:format) | search_user_profiles#update |
| PUT | /search_user_profiles/:id(.:format) | search_user_profiles#update |
| DELETE /search_user_profiles/:id(.:format) | search_user_profiles#destroy |  |
| rails_service_blob GET | /rails/active_storage/blobs/:signed_id/*filename(.:format) | active_storage/blobs#show |
| rails_blob_representation GET | /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show |  |
| rails_disk_service GET | /rails/active_storage/disk/:encoded_key/*filename(.:format) | active_storage/disk#show |
| update_rails_disk_service PUT | /rails/active_storage/disk/:encoded_token(.:format) | active_storage/disk#update |
| rails_direct_uploads POST | /rails/active_storage/direct_uploads(.:format) | active_storage/direct_uploads#create |
