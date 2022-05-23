package com.example.parking.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.example.parking.config.auth.CustomLoginSuccess;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    CustomLoginSuccess customLoginSuccess;

    @Bean
    public BCryptPasswordEncoder encodePwd() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.csrf()
                .disable()
                .authorizeHttpRequests()
                .antMatchers("/", "/register/**", "/js/**", "/img/**", "/lib/**") // 접근 허용
                .permitAll()
                .anyRequest()
                .permitAll()
                //.authenticated()
                // // .antMatchers("/admin/*").hasRole("ROLE_ADMIN")
                .and()
                .formLogin()
                .loginPage("/register/login")
                .successHandler(customLoginSuccess)
                // .defaultSuccessUrl("/")
                .failureUrl("/register/fail")
                .and()
                .logout()
                .logoutUrl("/register/logout")
                .logoutSuccessUrl("/register/login")
                .invalidateHttpSession(true);

    }
}
