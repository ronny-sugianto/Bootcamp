import React from 'react';
import '../../App.css';
class AuthForm extends React.Component {


    render() {
        return (
            <div className='auth-layout'>
                <form>
                    <input placeholder='Username' />
                    <br />
                    <input placeholder='Password' />
                    <br />
                    <button onSubmit='submit'>Sign In</button>
                </form>
            </div>


        );
    }


}
export default AuthForm;