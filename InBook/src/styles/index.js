import styled, {createGlobalStyle} from "styled-components";

export const colors = {
    main: '#155e63',
    secondary: '#519986',
    white: ' #fff',
    black: '#000',
}

export const breakpoints = {
    desktop: '1024px',
    tablet: '768px'
}

const GlobalCss = createGlobalStyle`
    *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Roboto;
        list-style: none;
    }

    small{
        color: ${colors.white};
    }
`

export const Title = styled.h1`
    font-size: 36px;
    font-weight: 900;
    text-align: center;
    color: ${colors.main};
`
export const SubTitle = styled.h2`
    font-size: 18px;
    font-weight: 700;
    text-align: left;
    color: ${colors.main};
`

export const Text = styled.p`
    font-size: 14px;
    font-weight: 400;
    line-height: 22px;
    text-align: left;
    color: ${colors.main};
`
export const Button = styled.button`
    padding: 3px 6px;
    font-size: 14px;
    font-weight: 700;
    text-align: center;
    cursor: pointer;
    color: ${colors.white};
    background-color: ${colors.main};
    border: solid ${colors.main};
`

export const Container = styled.div`
    max-width: 1024px;
    width: 100%;
    margin: 0 auto;

    @media (max-width: ${breakpoints.desktop}){
        max-width: 80%;
    }

    @media (max-width: ${breakpoints.tablet}){
        max-width: 90%;
    }
`
export const Input = styled.input`
    width: 100%;
    border: none;
    height: 32px;
    margin-bottom: 8px;
    padding: 8px;

    &.error{
        border: 1px solid red;
    }
`


export default GlobalCss