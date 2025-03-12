package ro.tuc.ds2020.services;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;
import ro.tuc.ds2020.Ds2020TestConfig;
import ro.tuc.ds2020.dtos.UserAccountDTO;
import ro.tuc.ds2020.dtos.UserAccountDetailsDTO;

import static org.springframework.test.util.AssertionErrors.assertEquals;

import java.util.List;
import java.util.UUID;

@Sql(executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD, scripts = "classpath:/test-sql/create.sql")
@Sql(executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD, scripts = "classpath:/test-sql/delete.sql")
public class UserAccountServiceIntegrationTests extends Ds2020TestConfig {

    @Autowired
    UserAccountService userAccountService;

    @Test
    public void testGetCorrect() {
        List<UserAccountDTO> userAccountDTOList = userAccountService.findUserAccounts();
        assertEquals("Test Insert UserAccount", 1, userAccountDTOList.size());
    }

    @Test
    public void testInsertCorrectWithGetById() {
        UserAccountDetailsDTO user = new UserAccountDetailsDTO("John", "client");
        UUID insertedID = userAccountService.insert(user);

        UserAccountDTO insertedUser = new UserAccountDTO(insertedID, user.getName(), user.getRole());
        UserAccountDTO fetchedUser = userAccountService.findUserAccountById(insertedID);

        assertEquals("Test Inserted UserAccount", insertedUser, fetchedUser);
    }

    @Test
    public void testInsertCorrectWithGetAll() {
        UserAccountDetailsDTO user = new UserAccountDetailsDTO("John", "client");
        userAccountService.insert(user);

        List<UserAccountDTO> userAccountDTOList = userAccountService.findUserAccounts();
        assertEquals("Test Inserted UserAccounts", 2, userAccountDTOList.size());
    }
}
