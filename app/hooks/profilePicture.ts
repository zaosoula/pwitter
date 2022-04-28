import { useContext } from '@nuxtjs/composition-api';

export const useProfilePicture = (identifier?: any) => {
  if(!identifier) {
    const { $auth: { user } } = useContext();
    identifier = user?.username || user?.email;
  }


  return `https://avatars.dicebear.com/api/adventurer-neutral/${identifier}.svg?scale=69&flip=1`;
}
