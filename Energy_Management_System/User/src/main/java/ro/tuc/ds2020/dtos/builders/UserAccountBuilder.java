package ro.tuc.ds2020.dtos.builders;

import ro.tuc.ds2020.dtos.UserAccountDTO;
import ro.tuc.ds2020.dtos.UserAccountDetailsDTO;
import ro.tuc.ds2020.entities.UserAccount;

public class UserAccountBuilder {

    private UserAccountBuilder() {
    }

    public static UserAccountDTO toUserAccountDTO(UserAccount userAccount) {
        return new UserAccountDTO(userAccount.getId(), userAccount.getName(), userAccount.getEmail(), userAccount.getPassword(), userAccount.getRole());
    }

    public static UserAccount toEntity(UserAccountDetailsDTO userAccountDetailsDTO) {
        return new UserAccount(userAccountDetailsDTO.getName(), userAccountDetailsDTO.getRole(),userAccountDetailsDTO.getPassword(), userAccountDetailsDTO.getEmail());
    }
}
